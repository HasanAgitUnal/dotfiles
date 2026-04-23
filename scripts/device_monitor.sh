#!/bin/bash
# USB olaylarını dinleyen geliştirilmiş script

# Get sound theme path
THEME_DIR="$HOME/.local/share/sounds/${CANBERRA_XDG_SOUND_THEME_NAME:-modern-minimal-ui-sounds}"

udevadm monitor --udev --subsystem-match=usb | while read -r line; do
    if echo "$line" | grep -q "add"; then
        mpv "$THEME_DIR/stereo/device-added".* --no-terminal &
    elif echo "$line" | grep -q "remove"; then
        mpv "$THEME_DIR/stereo/device-removed".* --no-terminal &
    fi
done
