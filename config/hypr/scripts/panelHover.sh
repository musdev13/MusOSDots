#!/bin/bash

while true; do
    # Get cursor position and extract Y coordinate
    cursor_pos=$(hyprctl cursorpos)
    y_pos=$(echo $cursor_pos | cut -d',' -f2 | tr -d ' ')

    # Check cursor Y position
    if [ "$y_pos" -lt 8 ]; then
        # Start waybar if it's not running
        if ! pgrep -x "waybar" > /dev/null; then
            waybar &
        fi
    elif [ "$y_pos" -gt 130 ]; then
        # Kill waybar if it's running
        pkill waybar
    fi

    # Small sleep to prevent high CPU usage
    sleep 0.1
done