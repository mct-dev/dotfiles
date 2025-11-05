#!/bin/bash

# Get the main wifi interface (usually en0 on Mac)
INTERFACE="en0"

# File to store previous stats
STATS_FILE="/tmp/sketchybar_wifi_stats"

# Get current stats
CURRENT_STATS=$(netstat -ibn | grep -m1 "$INTERFACE" | awk '{print $7":"$10}')
CURRENT_RX=$(echo "$CURRENT_STATS" | cut -d':' -f1)
CURRENT_TX=$(echo "$CURRENT_STATS" | cut -d':' -f2)
CURRENT_TIME=$(date +%s)

# Initialize if file doesn't exist
if [ ! -f "$STATS_FILE" ]; then
    echo "$CURRENT_TIME:$CURRENT_RX:$CURRENT_TX" > "$STATS_FILE"
    sketchybar --set wifi.speed.down label="-- KB/s" \
               --set wifi.speed.up label="-- KB/s"
    exit 0
fi

# Read previous stats
PREV_DATA=$(cat "$STATS_FILE")
PREV_TIME=$(echo "$PREV_DATA" | cut -d':' -f1)
PREV_RX=$(echo "$PREV_DATA" | cut -d':' -f2)
PREV_TX=$(echo "$PREV_DATA" | cut -d':' -f3)

# Calculate time difference
TIME_DIFF=$((CURRENT_TIME - PREV_TIME))

if [ "$TIME_DIFF" -eq 0 ]; then
    TIME_DIFF=1
fi

# Calculate speeds (bytes per second)
RX_SPEED=$(((CURRENT_RX - PREV_RX) / TIME_DIFF))
TX_SPEED=$(((CURRENT_TX - PREV_TX) / TIME_DIFF))

# Protect against negative values (happens when interface resets)
if [ "$RX_SPEED" -lt 0 ]; then
    RX_SPEED=0
fi
if [ "$TX_SPEED" -lt 0 ]; then
    TX_SPEED=0
fi

# Convert to human readable format
format_speed() {
    local speed=$1
    if [ "$speed" -gt 1048576 ]; then
        # MB/s
        echo "scale=1; $speed / 1048576" | bc | awk '{printf "%.1f MB/s", $1}'
    else
        # KB/s
        echo "scale=0; $speed / 1024" | bc | awk '{printf "%d KB/s", $1}'
    fi
}

RX_LABEL=$(format_speed "$RX_SPEED")
TX_LABEL=$(format_speed "$TX_SPEED")

# Calculate percentage for graph (max 100 Mbps = 12,500,000 bytes/s)
MAX_SPEED=12500000
RX_PERCENT=$(echo "scale=2; ($RX_SPEED * 100) / $MAX_SPEED" | bc)
TX_PERCENT=$(echo "scale=2; ($TX_SPEED * 100) / $MAX_SPEED" | bc)

# Cap between 0 and 100
RX_PERCENT=$(echo "$RX_PERCENT" | awk '{if($1>100) print "100"; else if($1<0) print "0"; else print $1}')
TX_PERCENT=$(echo "$TX_PERCENT" | awk '{if($1>100) print "100"; else if($1<0) print "0"; else print $1}')

# Ensure we have valid numbers (default to 0 if empty)
RX_PERCENT=${RX_PERCENT:-0}
TX_PERCENT=${TX_PERCENT:-0}

# Update sketchybar items
sketchybar --set wifi.speed.label label="$RX_LABEL" \
           --push wifi.speed.download "$RX_PERCENT" \
           --push wifi.speed.upload "$TX_PERCENT"

# Save current stats for next iteration
echo "$CURRENT_TIME:$CURRENT_RX:$CURRENT_TX" > "$STATS_FILE"
