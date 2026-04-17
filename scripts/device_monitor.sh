#!/bin/bash
# USB olaylarını dinleyen geliştirilmiş script
udevadm monitor --udev --subsystem-match=usb | while read -r line; do
    if echo "$line" | grep -q "add"; then
        canberra-gtk-play -i device-added &
    elif echo "$line" | grep -q "remove"; then
        canberra-gtk-play -i device-removed &
    fi
done
