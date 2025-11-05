#!/bin/bash

wifi_top=(
  label.font="$FONT:Semibold:7"
  label=WIFI
  icon.drawing=off
  width=0
  padding_right=15
  y_offset=6
)

wifi_label=(
  label.font="$FONT:Heavy:12"
  label="-- KB/s"
  y_offset=-4
  padding_left=20
  padding_right=15
  width=55
  icon.drawing=off
  update_freq=2
  script="$PLUGIN_DIR/wifi_speed.sh"
)

wifi_download=(
  width=0
  graph.color=$BLUE
  graph.fill_color=$BLUE
  label.drawing=off
  icon.drawing=off
  background.height=26
  background.drawing=on
  background.color=$TRANSPARENT
  y_offset=0
)

wifi_upload=(
  graph.color=$GREEN
  label.drawing=off
  icon.drawing=off
  background.height=26
  background.drawing=on
  background.color=$TRANSPARENT
  y_offset=0
)

sketchybar --add item wifi.speed.top right                \
           --set wifi.speed.top "${wifi_top[@]}"          \
                                                           \
           --add item wifi.speed.label right              \
           --set wifi.speed.label "${wifi_label[@]}"      \
                                                           \
           --add graph wifi.speed.download right 75       \
           --set wifi.speed.download "${wifi_download[@]}" \
                                                           \
           --add graph wifi.speed.upload right 75         \
           --set wifi.speed.upload "${wifi_upload[@]}"
