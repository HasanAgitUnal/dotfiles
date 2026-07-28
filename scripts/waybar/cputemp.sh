temps=($(sensors | grep -E "^Core [0-9]+:" | awk '{ print $3 }' | sed 's/+//;s/\.[0-9]*°C//'))
average=$(printf "%s\n" "${temps[@]}" | awk '{ sum += $1; n++ } END { printf "%.0f", sum / n }')
crit_temp=$(sensors | grep -E "^Core [0-9]+:" | awk '{ print $9 }' | sed 's/+//;s/\.[0-9]*°C)//' | head -n 1)

core_temps=""
for i in "${!temps[@]}"; do
    core_temps+="\nCore$i: ${temps[$i]}"
done

TEXT=" $average°C"
TIP="Average: $average°C$core_temps"

CLASS="normal"
if (( $average >= $crit_temp - 10 )); then
        CLASS="critical"
fi

echo "{\"text\": \"$TEXT\", \"tooltip\": \"$TIP\", \"class\": \"$CLASS\"}"
