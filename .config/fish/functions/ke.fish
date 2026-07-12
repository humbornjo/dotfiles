function ke --description 'Show Kubernetes events'
    argparse --ignore-unknown 'h/help' 'f/for=' 't/types=' 's/since=' -- $argv
    or return

    if set -q _flag_help
        printf '%s\n' \
            'Usage: ke [OPTIONS] [KUBECTL OPTIONS]' \
            '' \
            'Show Kubernetes events. Unknown options are passed to kubectl events.' \
            '' \
            'Options:' \
            '  -f, --for VALUE    Filter by resource, e.g. pod/my-pod' \
            '  -t, --types VALUE  Event types: Normal and/or Warning (default: both)' \
            '                      Abbreviations: n=Normal, w=Warning; e.g. -t n,w' \
            '  -s, --since VALUE  Show events newer than a duration, e.g. 30m, 2h' \
            '  -h, --help         Show this help' \
            '' \
            'Examples:' \
            '  ke -Aw' \
            '  ke -s 30m -Aw' \
            '  ke --for pod/neo-design-chatty-76b5bbb686-s2pzq -Aw' \
            '  ke --for pod/my-pod -t w --since 2h -Aw'
        return
    end

    set -l cmd kubectl events

    if set -q _flag_for; and test -n "$_flag_for"
        set -a cmd --for "$_flag_for"
    end

    set -l types Normal,Warning
    if set -q _flag_types
        set -l normalized_types
        for type in (string split ',' -- "$_flag_types")
            switch (string lower -- (string trim -- "$type"))
                case n normal
                    set -a normalized_types Normal
                case w warning
                    set -a normalized_types Warning
                case '*'
                    printf 'ke: invalid event type: %s (use Normal/Warning or n/w)\n' "$type" >&2
                    return 2
            end
        end
        set types (string join ',' -- $normalized_types)
    end

    set -a cmd --types "$types"

    if set -q _flag_since; and test -n "$_flag_since"
        set -a cmd --since "$_flag_since"
    end

    set -a cmd $argv

    command $cmd
end
