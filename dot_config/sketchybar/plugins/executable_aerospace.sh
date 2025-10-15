#!/usr/bin/env bash

# make sure it's executable with:
# chmod +x ~/.config/sketchybar/plugins/aerospace.sh

# $1 = workspace ID (e.g., "1", "2", "3")
# $FOCUSED_WORKSPACE = current focused workspace from aerospace trigger

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
    sketchybar --animate tanh 20 --set "$NAME" background.drawing=on
else
    sketchybar --animate tanh 20 --set "$NAME" background.drawing=off
fi
