function mihomo-down --description 'Stop the running Mihomo process'
    argparse 'h/help' -- $argv
    or return 2

    if set -q _flag_help
        echo "Usage: mihomo-down"
        echo "  Stops the running Mihomo process."
        return 0
    end

    if not pgrep -x mihomo >/dev/null
        echo "mihomo is not running."
        return 0
    end

    # Authenticate before signaling so a password prompt cannot leave a
    # half-stopped process.
    if not sudo -v
        echo "sudo authentication failed; mihomo was not stopped." >&2
        return 1
    end

    sudo pkill -TERM -x mihomo 2>/dev/null
    set -l waited 0
    while pgrep -x mihomo >/dev/null; and test $waited -lt 20
        sleep 0.25
        set waited (math $waited + 1)
    end

    if pgrep -x mihomo >/dev/null
        sudo pkill -KILL -x mihomo 2>/dev/null
        sleep 1
    end

    if pgrep -x mihomo >/dev/null
        echo "Failed to stop mihomo." >&2
        return 1
    end

    echo "mihomo stopped."
    return 0
end
