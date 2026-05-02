#!/bin/bash

SHADER_FILE="$HOME/dotfiles/.config/hypr/shaders/extra_brightness.glsl"
LOCK_FILE="$HOME/.brightnesslock"
VALUE=$1

# turning off
if [ "$VALUE" == "off" ]; then
    rm -f "$LOCK_FILE"
    hyprshade off
    exit 0
fi

# must give a value
if [ -z "$VALUE" ]; then
    echo "Usage: $0 <value|off>"
    exit 1
fi

# value should be int or float
if [[ ! $VALUE =~ ^[0-9]+(\.[0-9]+)?$ ]]; then
        echo "Value should be int or float"
        exit 1
fi
 
# Check value range 1-3
VALUE=$(awk -v v="$VALUE" 'BEGIN { if (v > 3) print 3; else if (v < 1) print 1; else print v }')

# Ensure float format for GLSL
if [[ ! $VALUE =~ \. ]]; then
    BRIGHTNESS="${VALUE}.0"
else
    BRIGHTNESS="$VALUE"
fi

# Update shader
sed -i "s/float multiplier = [0-9.]*;/float multiplier = $BRIGHTNESS;/" "$SHADER_FILE"

# Apply shader and create lock
hyprshade on "$SHADER_FILE"
touch "$LOCK_FILE"

echo "Brightness set to $BRIGHTNESS and lock created at $LOCK_FILE"
