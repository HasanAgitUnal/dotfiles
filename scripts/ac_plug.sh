#!/bin/bash

upower --monitor-detail | stdbuf -oL grep -E "state:|online:" | while read -r line; do
    if echo "$line" | grep -q "yes"; then
        canberra-gtk-play -i power-plug &
    elif echo "$line" | grep -q "no"; then
        canberra-gtk-play -i power-unplug &
    fi
done
