#!/bin/bash

front_app=(
  script="$PLUGIN_DIR/front_app.sh"
  icon.drawing=off
  padding_left=0
  label.color=$WHITE
  label.font="$FONT:Black:12.0"
  associated_display=active
)

sketchybar --add item front_app left           \
           --set front_app "${front_app[@]}"   \
           --subscribe front_app front_app_switched

