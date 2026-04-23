#!/bin/bash

# Get sound theme path
THEME_DIR="$HOME/.local/share/sounds/${CANBERRA_XDG_SOUND_THEME_NAME:-modern-minimal-ui-sounds}"

upower --monitor-detail | stdbuf -oL grep -E "state:|online:" | while read -r line; do
    if echo "$line" | grep -q "yes"; then
        mpv "$THEME_DIR/stereo/power-plug".* --no-terminal &
    elif echo "$line" | grep -q "no"; then
        mpv "$THEME_DIR/stereo/power-unplug".* --no-terminal &
    fi
done
