#!/bin/bash

# Get API Key and GUI address automatically
API_KEY=$(syncthing cli config gui apikey get)
GUI_ADDR="127.0.0.1:8384"

# Fetch folders and devices
FOLDERS=$(syncthing cli config folders list)
DEVICES=$(syncthing cli config devices list)

IS_SYNCED=true
TOTAL_COMPLETION=0
COUNT=0

for f in $FOLDERS; do
    for d in $DEVICES; do
        # We check completion for each folder-device pair
        # Note: We skip the local device's own completion check if necessary, 
        # but usually checking all remotes is what matters.
        RESPONSE=$(curl -s -H "X-API-Key: $API_KEY" "http://$GUI_ADDR/rest/db/completion?folder=$f&device=$d")
        COMPLETION=$(echo "$RESPONSE" | grep -oP '"completion":\s*\K[0-9.]+')
        
        if [ ! -z "$COMPLETION" ]; then
            # If any pair is less than 100, system is not fully synced
            if [ "$COMPLETION" != "100" ] && [ "$COMPLETION" != "100.0" ]; then
                IS_SYNCED=false
            fi
            # We don't really need TOTAL_COMPLETION for this logic, so removing it to avoid bc
            COUNT=$((COUNT + 1))
        fi
    done
done

if [ "$IS_SYNCED" = true ]; then
    ICON=""
    CLASS="synced"
    TEXT="Synced"
else
    ICON="󰚰"
    CLASS="syncing"
    TEXT="Syncing..."
fi

# Output JSON for Waybar
echo "{\"text\": \"$ICON\", \"tooltip\": \"$TEXT\", \"class\": \"$CLASS\"}"
