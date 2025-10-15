#!/bin/bash

weather=(
  icon.font="$FONT:Regular:15.0"
  icon.padding_right=5
  label.padding_right=10
  update_freq=1800  # Update every 30 minutes
  script="$PLUGIN_DIR/weather.sh"
  click_script="open 'https://wttr.in'"
)

sketchybar --add item weather right       \
           --set weather "${weather[@]}"  \
           --subscribe weather system_woke

