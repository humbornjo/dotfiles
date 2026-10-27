function mihomo-up
    if pgrep -x mihomo >/dev/null
        echo "mihomo is already running."
        return 0
    end

    # Start fully detached—no Ctrl-Z, bg, or disown needed.
    if not sudo sh -c \
        'nohup mihomo -d /etc/mihomo >/var/log/mihomo.log 2>&1 &'
        echo "Failed to start mihomo." >&2
        return 1
    end

    sleep 1

    if pgrep -x mihomo >/dev/null
        echo "mihomo started successfully."
    else
        echo "mihomo did not start; check /var/log/mihomo.log." >&2
        return 1
    end
end
