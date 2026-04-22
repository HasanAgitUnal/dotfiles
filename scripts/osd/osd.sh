#!/bin/bash

#
# DUNST OSD
# A simple and minimalist osd tool
# better than swayosd and avizo osd tools (for me)
# and unlicensed everyone can use
#

RATE_LIMIT=1000
LAST_RUN_FILE="/tmp/osd_last_run"
CURRENT_TIME=$(date +%s%3N)

if [ -f "$LAST_RUN_FILE" ]; then
        LAST_TIME=$(cat "$LAST_RUN_FILE")
        ELAPSED=$(( CURRENT_TIME - LAST_TIME ))
        if [ "$ELAPSED" -gt 0 ] && [ "$ELAPSED" -lt "$RATE_LIMIT" ]; then
                exit 0
        fi
fi
echo "$CURRENT_TIME" > "$LAST_RUN_FILE"

#
#   VARIABLES & CONFIGS
#
CONF_BAR="$HOME/dotfiles/scripts/osd/dunstrc_bar.ini"
CONF_TOGGLE="$HOME/dotfiles/scripts/osd/dunstrc_toggle.ini"

LOGFILE="$HOME/dotfiles/scripts/osd/log.txt"

# DBUS SOCKETS
SOCKET_BAR="/tmp/dunst_osd_bar.sock"
SOCKET_TOGGLE="/tmp/dunst_osd_toggle.sock"

#
#   PRIVATE DBUS & DUNST MANAGER
#
setup_env() {
        local socket=$1
        local conf=$2

        if [ ! -e "$socket" ]; then
                dbus-daemon --session --address="unix:path=$socket" --nofork --nopidfile &
                sleep 0.1
        fi

        # Set dbus address
        export DBUS_SESSION_BUS_ADDRESS="unix:path=$socket"

        # start dunst if not running with $conf
        if ! pgrep -f "dunst -conf $conf" > /dev/null; then
                dunst -conf "$conf" > /dev/null 2>&1 &
                sleep 0.1
        fi
}

#
#   FUNCTIONS
#

show_bar() {
        local icon=$1
        local val=$2
        setup_env "$SOCKET_BAR" "$CONF_BAR"

        # Use Dunst's built-in progress bar hint
        notify-send "$icon" "$val%" -h int:value:"$val" -h string:x-dunst-stack-tag:OSD
}

show_toggle() {
        local icon=$1
        setup_env "$SOCKET_TOGGLE" "$CONF_TOGGLE"
        notify-send "$icon" "" -h string:x-dunst-stack-tag:OSD
}

get_vol_icon() {
        local v=$1
        local m=$2

        # return mute icon if muted
        if [ "$m" = "true" ]; then 
                echo "󰝟"; 
                return; 
        fi

        if [ "$v" -le 30 ]; then
                echo "󰕿"; 
        elif [ "$v" -le 70 ]; then 
                echo "󰖀"; 
        else 
                echo "󰕾"; 
        fi
}

get_bri_icon() {
        local b=$1

        if [ "$b" -le 30 ]; then 
                echo "󰃞"; 
        elif [ "$b" -le 70 ]; then 
                echo "󰃟"; 
        else 
                echo "󰃠"; 
        fi
}

#
#   MAIN LOGIC
#
ACTION=$1
PARAM=$2

case $ACTION in
        --help|-h)
                echo "Usage: osd.sh [volume|brightness|mute-volume|mute-mic] [+n|-n|n]"
                exit 0
                ;;
        volume)
                pamixer --unmute
                if [[ $PARAM == +* ]]; then
                        pamixer --increase "${PARAM#+}"
                elif [[ $PARAM == -* ]]; then
                        pamixer --decrease "${PARAM#-}"
                else 
                        pamixer --set-volume "$PARAM"
                fi
                VOL=$(pamixer --get-volume)
                ICON=$(get_vol_icon "$VOL" "false")
                show_bar "$ICON" "$VOL"
                canberra-gtk-play -i audio-volume-change
                ;;
        brightness)
                if [[ $PARAM == -* ]]; then
                        brightnessctl set "${PARAM#-}%-"
                elif [[ $PARAM == +* ]]; then
                        brightnessctl set "${PARAM#+}%+"
                else
                        brightnessctl set "${PARAM}%"
                fi
                BRI=$(brightnessctl -m | head -n1 | cut -d, -f4 | tr -d %)
                ICON=$(get_bri_icon "$BRI")
                show_bar "$ICON" "$BRI"
                ;;
        mute-volume)
                pamixer -t
                VOL=$(pamixer --get-volume)
                MUTE=$(pamixer --get-mute)
                ICON=$(get_vol_icon "$VOL" "$MUTE")
                show_toggle "$ICON"
                ;;
        mute-mic)
                pamixer --default-source -t
                MUTE=$(pamixer --default-source --get-mute)
                ICON=$([ "$MUTE" = "true" ] && echo "" || echo "")
                show_toggle "$ICON"
                ;;
        *)
                echo "Usage: osd.sh [volume|brightness|mute-volume|mute-mic] [+n|-n|n]" > $LOGFILE
                echo "Usage: osd.sh [volume|brightness|mute-volume|mute-mic] [+n|-n|n]"
                exit 1
                ;;
esac
