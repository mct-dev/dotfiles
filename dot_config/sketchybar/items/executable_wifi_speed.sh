#!/bin/bash

wifi=(
  icon=􀙇
  icon.font="$FONT:Bold:16.0"
  label="-- KB/s"
  label.font="$FONT:Semibold:12"
  update_freq=2
  script="$PLUGIN_DIR/wifi_speed.sh"
  padding_right=10
  padding_left=10
)

sketchybar --add item wifi right \
           --set wifi "${wifi[@]}"
