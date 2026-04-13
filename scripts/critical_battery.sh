#!/bin/bash

# Configuration
BATTERY_PATH="/sys/class/power_supply/BAT0"
INTERVAL=20

# Notification flags to prevent spamming
SENT_15=false
SENT_2=false

while true; do
    if [ -d "$BATTERY_PATH" ]; then
        STATUS=$(cat "$BATTERY_PATH/status")
        LEVEL=$(cat "$BATTERY_PATH/capacity")

        if [ "$STATUS" = "Discharging" ]; then
            # Priority 1: 1% - Shutdown
            if [ "$LEVEL" -le 1 ]; then
                notify-send -u critical "Battery Is Critical" "You should listen me..."
                sleep 5
                notify-send -u critical "Battery Is Critical" "Shutting down..."
                sleep 2
                systemctl poweroff 
                exit 0
            
            # Priority 2: 2% - Closing Computer Warning
            elif [ "$LEVEL" -le 2 ]; then
                if [ "$SENT_2" = false ]; then
                    notify-send -u critical "Battery Is Critical" "Closing Computer!!"
                    SENT_2=true
                fi
            
            # Priority 3: 15% - Battery Low Warning
            elif [ "$LEVEL" -le 15 ]; then
                if [ "$SENT_15" = false ]; then
                    notify-send -u critical "Battery Is Critical" "Battery level reached %15"
                    SENT_15=true
                fi
            fi
        else
            # Reset flags if we are charging
            SENT_15=false
            SENT_2=false
        fi
    fi
    sleep "$INTERVAL"
done
