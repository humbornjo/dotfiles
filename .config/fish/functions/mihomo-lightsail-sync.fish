# Managed relays are Lightsail instances tagged mihomo-relay=<Mihomo proxy name>.
# Defaults: profile mihomo, region ap-southeast-1, tag mihomo-relay.
function mihomo-lightsail-sync --description 'Print a JSON sync plan for tagged AWS Lightsail relays'
    set -l config /etc/mihomo/config.yaml
    if set -q MIHOMO_CONFIG
        set config $MIHOMO_CONFIG
    end

    set -l profile mihomo
    if set -q MIHOMO_AWS_PROFILE
        set profile $MIHOMO_AWS_PROFILE
    end

    set -l region ap-southeast-1
    if set -q MIHOMO_AWS_REGION
        set region $MIHOMO_AWS_REGION
    end

    set -l tag mihomo-relay
    if set -q MIHOMO_LIGHTSAIL_TAG
        set tag $MIHOMO_LIGHTSAIL_TAG
    end

    for command_name in aws jq yq
        if not command -q $command_name
            echo "mihomo-lightsail-sync: $command_name is not installed; skipping Lightsail sync." >&2
            return 3
        end
    end

    if not test -r "$config"
        echo "mihomo-lightsail-sync: cannot read $config; skipping Lightsail sync." >&2
        return 3
    end

    set -l aws_raw (aws lightsail get-instances \
        --profile "$profile" \
        --region "$region" \
        --output json \
        --no-cli-pager \
        --cli-connect-timeout 5 \
        --cli-read-timeout 10 2>/dev/null)
    if test $status -ne 0
        echo "mihomo-lightsail-sync: AWS Lightsail query failed for profile '$profile' in '$region'." >&2
        echo "Run 'aws sso login --profile $profile' and retry." >&2
        return 3
    end

    if test (count $aws_raw) -eq 0
        echo "mihomo-lightsail-sync: AWS returned no data; skipping Lightsail sync." >&2
        return 3
    end

    set -l config_raw (yq -o=json '.' "$config" 2>/dev/null)
    if test $status -ne 0
        echo "mihomo-lightsail-sync: cannot parse $config; skipping Lightsail sync." >&2
        return 3
    end

    set -l aws_json (printf '%s\n' $aws_raw | string collect)
    set -l config_json (printf '%s\n' $config_raw | string collect)

    set -l plan (jq -n -c \
        --argjson aws "$aws_json" \
        --argjson cfg "$config_json" \
        --arg tag "$tag" '
        def tag_value($instance):
          (($instance.tags // []) | map(select(.key == $tag)) | first | .value);

        ($cfg.proxies // []) as $proxies
        | reduce $aws.instances[] as $instance (
            {instances: [], warnings: []};
            (tag_value($instance)) as $node
            | if $node == null or $node == "" then
                .
              elif (($instance.state.name // "") != "running") then
                .warnings += ["\($instance.name): tagged relay is not running; skipping"]
              else
                ($proxies | map(select(.name == $node))) as $matches
                | if ($matches | length) == 0 then
                    .warnings += ["\($instance.name): no Mihomo proxy named \"\($node)\"; skipping"]
                  elif ($matches | length) > 1 then
                    .warnings += ["\($instance.name): multiple Mihomo proxies named \"\($node)\"; skipping"]
                  else
                    ($matches[0]) as $proxy
                    | .instances += [{
                        instance: $instance.name,
                        node: $node,
                        port: ($proxy.port // 443),
                        current: ($proxy.server // ""),
                        candidates: (
                          [ (($instance.ipv6Addresses // [])[0]), $instance.publicIpAddress ]
                          | map(select(type == "string" and . != ""))
                          | reduce .[] as $address ([]; if index($address) then . else . + [$address] end)
                        )
                      }]
                  end
              end
          )
        ' 2>/dev/null)

    if test $status -ne 0 -o (count $plan) -eq 0
        echo "mihomo-lightsail-sync: could not build a sync plan." >&2
        return 3
    end

    printf '%s\n' $plan
    return 0
end
