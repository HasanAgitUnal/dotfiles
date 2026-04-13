#!/bin/bash

BATTERY_PATH="/sys/class/power_supply/BAT0"
INTERVAL=30

while true; do
    if [ -d "$BATTERY_PATH" ]; then
        STATUS=$(cat "$BATTERY_PATH/status")
        LEVEL=$(cat "$BATTERY_PATH/capacity")
        
        # Check for lock file
        if [ -f "$HOME/.powerlock" ]; then
            sleep "$INTERVAL"
            continue
        fi

        CURRENT_PROFILE=$(powerprofilesctl get)
        
        # Determine target profile based on charging status and level
        if [ "$STATUS" = "Charging" ] || [ "$STATUS" = "Full" ]; then
            TARGET_PROFILE="performance"
        elif [ "$LEVEL" -gt 50 ]; then
            TARGET_PROFILE="balanced"
        else
            TARGET_PROFILE="power-saver"
        fi

        # Set the target profile if different from current
        if [ "$CURRENT_PROFILE" != "$TARGET_PROFILE" ]; then
            powerprofilesctl set "$TARGET_PROFILE"
        fi
    fi
    sleep "$INTERVAL"
done
