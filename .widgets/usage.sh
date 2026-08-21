center() {
        local pad="${1:-0}"
        local spaces=$(printf "%*s" "$pad" "")
        if [ -n "$2" ]; then
                echo "$2" | sed "s/^/$spaces/"
        else
                sed "s/^/$spaces/"
        fi
}

# padding
echo

# RAM
ram_total_m=$(free -m | awk '/^Mem:/ {print $2}')
ram_avail_m=$(free -m | awk '/^Mem:/ {print $7}')
ram_used_m=$((ram_total_m - ram_avail_m))
ram_percent=$((ram_used_m * 100 / ram_total_m))
ram_raw=$(free -h | awk '/^Mem:/ {print $2 "/" $7}')
ram_info="RAM: $ram_raw ($ram_percent%)"
ram_info=$(echo "$ram_info" | sed 's/\([0-9]\)Gi/\1 GiB/g; s/\([0-9]\)Mi/\1 MiB/g; s/\// \/ /g')
center "$1" "$ram_info"

# STORAGE
storage_raw=$(df -h /data | awk 'NR==2 {print $2 "/" $4 " (" $5 ")"}')
storage_info="STORAGE: $storage_raw"
storage_info=$(echo "$storage_info" | sed 's/\([0-9]\)G/\1 GiB/g; s/\([0-9]\)M/\1 MiB/g; s/\([0-9]\)T/\1 TiB/g; s/\// \/ /g')
center "$1" "$storage_info"

# SD kart
sd_mount=$(df -h | awk '/\/storage\/[0-9A-Z]{4}-[0-9A-Z]{4}/ {print $6; exit}')
if [ -n "$sd_mount" ]; then
    sd_raw=$(df -h "$sd_mount" | awk 'NR==2 {print $2 "/" $4 " (" $5 ")"}')
    sd_info="SD: $sd_raw"
    sd_info=$(echo "$sd_info" | sed 's/\([0-9]\)G/\1 GiB/g; s/\([0-9]\)M/\1 MiB/g; s/\([0-9]\)T/\1 TiB/g; s/\// \/ /g')
    center "$1" "$sd_info"
fi

echo
date '+%d.%m.%Y' | center $1
