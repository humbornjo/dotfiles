function mihomo-roll
    if test (count $argv) -ne 1
        echo "Usage: mihomo-roll <subscription-url>" >&2
        return 2
    end

    set -l tmp (mktemp /tmp/mihomo-config.XXXXXX)
    or return 1

    # Download the subscription.
    if not curl -fsSL "$argv[1]" -o "$tmp"
        rm -f "$tmp"
        return 1
    end

    # Add or replace external-controller.
    if not yq -i -p=yaml -o=yaml \
        '."external-controller" = "127.0.0.1:9090"' "$tmp"
        rm -f "$tmp"
        return 1
    end

    # Validate before replacing the current configuration.
    if not sudo mihomo -t -d /etc/mihomo -f "$tmp"
        echo "Invalid config; keeping the existing one." >&2
        rm -f "$tmp"
        return 1
    end

    # Install the new config.
    if not sudo install -m 600 "$tmp" /etc/mihomo/config.yaml
        rm -f "$tmp"
        return 1
    end

    rm -f "$tmp"

    # Stop the current instance, if any, then start with the new config.
    sudo pkill -x mihomo 2>/dev/null
    sleep 1

    if mihomo-up
        echo "mihomo updated and restarted successfully."
    else
        return 1
    end
end
