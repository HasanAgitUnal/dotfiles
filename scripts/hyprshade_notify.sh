#!/bin/bash

old_shader=$(hyprshade current)

hyprshade auto

new_shader=$(hyprshade current)

if [ "$old_shader" != "$new_shader" ]; then
    if [ -n "$new_shader" ]; then
        notify-send "Night Mode" "Enabled automaticaly" -u low
    else
        notify-send "Night Mode" "Disabled automaticaly" -u low
    fi
fi
