center() {
        local pad="${1:-0}"
        local spaces=$(printf "%*s" "$pad" "")
        if [ -n "$2" ]; then
                echo "$2" | sed "s/^/$spaces/"
        else
                sed "s/^/$spaces/"
        fi
}

date '+%H:%M' | center $1
