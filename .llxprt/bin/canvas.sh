#!/bin/bash

set -e

MODE="$1"

if [[ -z "$MODE" ]]; then
        echo "E: no mode specified. Usage: $0 MODE" >&2
        exit 1
fi

if [[ -z "$(cat /tmp/llxprt/canvas_data.json)" ]]; then
        echo "E: data is empty" >&2
        exit 1
fi

# Start canvas
footclient \
        --title "Canvas" \
        --app-id "canvas" \
        -o main.font='CaskaydiaCove Nerd Font:size=14' \
        sh -c "$HOME/.local/bin/canvas $MODE \"\$(cat /tmp/llxprt/canvas_data.json)\"" &

echo "Canvas started at background. Wait for user to view output."
