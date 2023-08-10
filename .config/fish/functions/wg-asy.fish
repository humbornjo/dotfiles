function wg-asy
    if string match -q -- "help" $argv
        echo "Usage: wg-asy [change|stop|show|help]"
        return
    end

    set interface "asy"

    if string match -q -- "show" $argv
        if $WG_ASY -eq -1 
            echo "Status: IDEL"
        else
            echo "Status: $interface$WG_ASY activated"
        end
        return
    end

    if string match -q -- "stop" $argv
        wg-quick down $interface$WG_ASY
        set -g WG_ASY -1
        return
    end

    if test $WG_ASY -gt -1
        wg-quick down $interface$WG_ASY
    end

    set -g WG_ASY (math "($WG_ASY+1)%4")
    wg-quick up $interface$WG_ASY
end
