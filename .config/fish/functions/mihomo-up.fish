function mihomo-up --description 'Refresh tagged Lightsail relay addresses and start Mihomo'
    argparse 'n/no-sync' 'd/dry-run' 'h/help' -- $argv
    or return 2

    if set -q _flag_help
        echo "Usage: mihomo-up [--no-sync] [--dry-run]"
        echo "  Refreshes tagged AWS Lightsail relay addresses, then starts Mihomo."
        echo "  --no-sync  Skip AWS Lightsail discovery."
        echo "  --dry-run  Show the discovery plan without changing config or processes."
        echo "  Relays are Lightsail instances tagged mihomo-relay=<Mihomo proxy name>."
        return 0
    end

    set -l config /etc/mihomo/config.yaml
    if set -q MIHOMO_CONFIG
        set config $MIHOMO_CONFIG
    end

    set -l api http://127.0.0.1:9090
    if set -q MIHOMO_API
        set api $MIHOMO_API
    end

    set -l was_running 0
    set -l tun_was_enabled 0
    if pgrep -x mihomo >/dev/null
        set was_running 1
        set -l tun_state (curl -fsS --max-time 2 "$api/configs" 2>/dev/null | jq -r '.tun.enable // false' 2>/dev/null)
        if test "$tun_state" = true
            set tun_was_enabled 1
        end
    end

    # Keep the credential-bearing config private. Normalize ownership so the
    # current user can read and update it after `mihomo-roll`.
    if not set -q _flag_dry_run
        if test -e "$config"
            if test (stat -f '%Su' "$config") != (id -un)
                sudo chown (id -un):wheel "$config" 2>/dev/null
            end
            chmod 600 "$config" 2>/dev/null
        end
        if test -e /etc/mihomo/config.yaml.pre-lightsail-sync
            chmod 600 /etc/mihomo/config.yaml.pre-lightsail-sync 2>/dev/null
        end
    end

    set -l plan '{"instances":[],"warnings":[]}'
    set -l sync_ok 1
    if not set -q _flag_no_sync
        set -l plan_parts (mihomo-lightsail-sync)
        set -l sync_status $status
        if test $sync_status -eq 0 -a (count $plan_parts) -gt 0
            set plan $plan_parts[1]
            if not printf '%s\n' "$plan" | jq -e . >/dev/null 2>&1
                echo "warning: invalid Lightsail sync plan; using the existing configuration." >&2
                set sync_ok 0
            end
        else
            set sync_ok 0
            echo "warning: Lightsail sync skipped; using the existing configuration." >&2
        end
    end

    set -l entries
    if test $sync_ok -eq 1
        for warning in (printf '%s\n' "$plan" | jq -r '.warnings[]?' 2>/dev/null)
            echo "warning: $warning" >&2
        end
        set entries (printf '%s\n' "$plan" | jq -c '.instances[]' 2>/dev/null)
    end

    if set -q _flag_dry_run
        printf '%s\n' "$plan" | jq .
        if test $was_running -eq 1
            echo "mihomo is running; no changes were made."
        else
            echo "mihomo is not running; no changes were made."
        end
        test $sync_ok -eq 1
        return $status
    end

    # Decide whether a restart and address probe are needed.
    set -l needs_probe 0
    if test $was_running -eq 0
        set needs_probe 1
    else
        for entry in $entries
            set -l current (printf '%s' "$entry" | jq -r '.current')
            set -l candidates (printf '%s' "$entry" | jq -r '.candidates[]')
            if not contains -- "$current" $candidates
                set needs_probe 1
            end
        end

        if test $needs_probe -eq 0
            for entry in $entries
                set -l node (printf '%s' "$entry" | jq -r '.node')
                set -l delay (__mihomo_node_delay "$node")
                if test -n "$delay"
                    echo "$node health: $delay ms"
                else
                    echo "warning: $node is not healthy; checking alternate addresses." >&2
                    set needs_probe 1
                end
            end
        end

        if test $needs_probe -eq 0
            if test $sync_ok -eq 0
                echo "mihomo is already running; using the existing configuration."
            else if test (count $entries) -gt 0
                echo "mihomo is already running; Lightsail addresses unchanged."
            else
                echo "mihomo is already running; no tagged Lightsail relays to sync."
            end
            return 0
        end
    end

    if test (count $entries) -eq 0 -a $was_running -eq 1
        if test $sync_ok -eq 0
            echo "mihomo is already running; using the existing configuration."
        else
            echo "mihomo is already running; no tagged Lightsail relays to sync."
        end
        return 0
    end

    # TUN intercepts local probes, so it must be down before testing the real
    # direct path to each candidate address. Authenticate before stopping so a
    # password prompt cannot leave the network down.
    if test $was_running -eq 1
        if not sudo -v
            echo "sudo authentication failed; leaving mihomo unchanged." >&2
            return 1
        end
        echo "Stopping mihomo to probe direct routes..." >&2
        sudo pkill -x mihomo 2>/dev/null
        set -l waited 0
        while pgrep -x mihomo >/dev/null; and test $waited -lt 20
            sleep 0.25
            set waited (math $waited + 1)
        end
        if pgrep -x mihomo >/dev/null
            echo "Failed to stop mihomo; leaving it running." >&2
            return 1
        end
    end

    set -l probe_py '
import json, socket, sys, time
from concurrent.futures import ThreadPoolExecutor

def probe(address, port):
    try:
        infos = socket.getaddrinfo(address, port, type=socket.SOCK_STREAM)
        family, socktype, proto, _, sockaddr = infos[0]
        sock = socket.socket(family, socktype, proto)
        sock.settimeout(3.0)
        start = time.monotonic()
        try:
            sock.connect(sockaddr)
            return round((time.monotonic() - start) * 1000)
        finally:
            sock.close()
    except Exception:
        return None

rows = [json.loads(line) for line in sys.stdin if line.strip()]
for row in rows:
    candidates = row.get("candidates") or []
    port = int(row.get("port") or 443)
    with ThreadPoolExecutor(max_workers=max(1, len(candidates))) as executor:
        results = list(executor.map(lambda address: probe(address, port), candidates))
    reachable = [(address, ms) for address, ms in zip(candidates, results) if ms is not None]
    current = row.get("current") or ""
    if reachable:
        reachable.sort(key=lambda item: item[1])
        best_address, best_ms = reachable[0]
        current_ms = next((ms for address, ms in reachable if address == current), None)
        if current_ms is not None and current_ms <= best_ms + 20:
            best_address, best_ms = current, current_ms
        row["best"] = {"address": best_address, "delay_ms": best_ms}
    else:
        row["best"] = {"address": current, "delay_ms": None}
    row["probes"] = dict(zip(candidates, results))
    print(json.dumps(row, separators=(",", ":")))
'

    set -l selected
    if test (count $entries) -gt 0
        if not command -q python3
            echo "warning: python3 is not installed; keeping existing addresses." >&2
        else
            set selected (printf '%s\n' $entries | python3 -c "$probe_py")
            if test $status -ne 0
                echo "Address probing failed; keeping existing addresses." >&2
                set selected
            end
        end

        for row in $selected
            set -l node (printf '%s' "$row" | jq -r '.node')
            set -l current (printf '%s' "$row" | jq -r '.current')
            set -l best (printf '%s' "$row" | jq -r '.best.address // empty')
            set -l best_ms (printf '%s' "$row" | jq -r '.best.delay_ms // empty')
            set -l probes (printf '%s' "$row" | jq -r '.probes | to_entries | map("\(.key)=\(.value // "unreachable")") | join(", ")')
            if test -n "$best_ms"
                if test "$best" = "$current"
                    echo "$node: $probes; keeping $current ($best_ms ms)" >&2
                else
                    echo "$node: $probes; selecting $best ($best_ms ms)" >&2
                end
            else
                echo "$node: $probes; no candidate reachable, keeping $current" >&2
            end
        end
    end

    # Apply all address changes to one temporary config, then validate once.
    set -l updates
    for row in $selected
        set -l current (printf '%s' "$row" | jq -r '.current')
        set -l best (printf '%s' "$row" | jq -r '.best.address // empty')
        if test -n "$best" -a "$best" != "$current"
            set updates $updates "$row"
        end
    end

    if test (count $updates) -gt 0
        set -l tmp (mktemp /tmp/mihomo-lightsail.XXXXXX)
        if test $status -ne 0
            echo "Could not create a temporary config; keeping existing addresses." >&2
        else
            chmod 600 "$tmp"
            if not cp "$config" "$tmp"
                echo "Could not copy the config; keeping existing addresses." >&2
            else
                set -l apply_ok 1
                for row in $updates
                    set -l node (printf '%s' "$row" | jq -r '.node')
                    set -l address (printf '%s' "$row" | jq -r '.best.address')
                    if not env NODE_NAME="$node" NEW_ADDR="$address" yq -i -p=yaml -o=yaml \
                        '(.proxies[] | select(.name == strenv(NODE_NAME)) | .server) = strenv(NEW_ADDR)' "$tmp"
                        echo "Failed to update $node in the temporary config." >&2
                        set apply_ok 0
                        break
                    end
                end

                if test $apply_ok -eq 1
                    if not sudo mihomo -t -d /etc/mihomo -f "$tmp"
                        echo "New config failed validation; keeping the previous one." >&2
                    else
                        set -l owner (stat -f '%Su' "$config")
                        set -l group (stat -f '%Sg' "$config")
                        if sudo cp -p "$config" /etc/mihomo/config.yaml.pre-lightsail-sync
                            and sudo chmod 600 /etc/mihomo/config.yaml.pre-lightsail-sync
                            and sudo install -o "$owner" -g "$group" -m 600 "$tmp" "$config"
                            echo "Updated Lightsail relay addresses." >&2
                        else
                            echo "Failed to install the new config; keeping the previous one." >&2
                        end
                    end
                end
            end
            rm -f "$tmp"
        end
    end

    # Start with the refreshed config.
    if not pgrep -x mihomo >/dev/null
        if not sudo -v
            echo "sudo authentication failed; mihomo is not running." >&2
            return 1
        end
        if not sudo sh -c 'nohup mihomo -d /etc/mihomo >/var/log/mihomo.log 2>&1 &'
            echo "Failed to start mihomo." >&2
            return 1
        end
        sleep 1
        if not pgrep -x mihomo >/dev/null
            echo "mihomo did not start; check /var/log/mihomo.log." >&2
            return 1
        end
        echo "mihomo started."
    end

    set -l api_ready 0
    for attempt in (seq 1 40)
        if curl -fsS --max-time 1 "$api/version" >/dev/null 2>&1
            set api_ready 1
            break
        end
        sleep 0.25
    end
    if test $api_ready -eq 0
        echo "warning: mihomo API is not responding; skipping TUN restore and health checks." >&2
        return 0
    end

    if test $tun_was_enabled -eq 1
        if curl -fsS -X PATCH -H 'Content-Type: application/json' \
            -d '{"tun":{"enable":true}}' "$api/configs" >/dev/null 2>&1
            sleep 1
            set -l tun_now (curl -fsS --max-time 2 "$api/configs" 2>/dev/null | jq -r '.tun.enable // false' 2>/dev/null)
            if test "$tun_now" = true
                echo "Restored Mihomo TUN."
            else
                echo "warning: could not confirm Mihomo TUN restoration." >&2
            end
        else
            echo "warning: could not restore Mihomo TUN." >&2
        end
    end

    for entry in $entries
        set -l node (printf '%s' "$entry" | jq -r '.node')
        set -l delay
        for attempt in (seq 1 3)
            set delay (__mihomo_node_delay "$node")
            if test -n "$delay"
                break
            end
            sleep 1
        end
        if test -n "$delay"
            echo "$node health: $delay ms"
        else
            echo "warning: $node health check failed." >&2
        end
    end

    return 0
end

function __mihomo_node_delay --argument-names node
    set -l api http://127.0.0.1:9090
    if set -q MIHOMO_API
        set api $MIHOMO_API
    end

    set -l encoded (jq -rn --arg name "$node" '$name | @uri' 2>/dev/null)
    if test -z "$encoded"
        return 1
    end

    set -l result (curl -fsS --max-time 12 --get \
        --data-urlencode 'url=https://www.gstatic.com/generate_204' \
        --data-urlencode 'timeout=10000' \
        "$api/proxies/$encoded/delay" 2>/dev/null)
    if test $status -ne 0
        return 1
    end

    set -l delay (printf '%s' "$result" | jq -r '.delay // empty' 2>/dev/null)
    if test -n "$delay"
        echo "$delay"
        return 0
    end
    return 1
end
