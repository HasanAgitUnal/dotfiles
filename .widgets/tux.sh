center() {
        local pad="${1:-0}"
        local spaces=$(printf "%*s" "$pad" "")
        if [ -n "$2" ]; then
                echo "$2" | sed "s/^/$spaces/"
        else
                sed "s/^/$spaces/"
        fi
}

{
        cat <<'EOF'
    .--.
   |o_o |
   |:_/ |
  //   \ \
 (|     | )
/'\_   _/`\
\___)=(___/
EOF
echo

up_raw=$(uptime -p | sed 's/^up //')
up_days=$(echo "$up_raw" | grep -oE '[0-9]+ day' | sed 's/ day/d/')
up_hours=$(echo "$up_raw" | grep -oE '[0-9]+ hour' | sed 's/ hour/h/')
if [ -z "$up_days" ] && [ -z "$up_hours" ]; then
        echo "UP: < 1h"
else
        echo "UP: $up_days $up_hours" | sed 's/  */ /g; s/^ *//; s/ *$//'
fi

} | center "$1"
