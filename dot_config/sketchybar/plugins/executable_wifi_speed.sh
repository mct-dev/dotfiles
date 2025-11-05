#!/bin/bash

# Get the main wifi interface (usually en0 on Mac)
INTERFACE="en0"

# File to store previous stats
STATS_FILE="/tmp/sketchybar_wifi_stats"

# Check if wifi is connected by checking interface status
WIFI_STATUS=$(ifconfig "$INTERFACE" 2>/dev/null | grep "status:" | awk '{print $2}')

# Determine wifi icon based on connection status
if [ "$WIFI_STATUS" != "active" ]; then
    WIFI_ICON="􀙈"  # wifi.slash
    SPEED_LABEL="Disconnected"
else
    # Connected - use wifi icon
    WIFI_ICON="􀙇"  # wifi icon

    # Get current stats
    CURRENT_STATS=$(netstat -ibn | grep -m1 "$INTERFACE" | awk '{print $7":"$10}')
    CURRENT_RX=$(echo "$CURRENT_STATS" | cut -d':' -f1)
    CURRENT_TX=$(echo "$CURRENT_STATS" | cut -d':' -f2)
    CURRENT_TIME=$(date +%s)

    # Initialize if file doesn't exist
    if [ ! -f "$STATS_FILE" ]; then
        echo "$CURRENT_TIME:$CURRENT_RX:$CURRENT_TX" > "$STATS_FILE"
        SPEED_LABEL="-- KB/s"
    else
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

        # Calculate download speed (bytes per second)
        RX_SPEED=$(((CURRENT_RX - PREV_RX) / TIME_DIFF))

        # Protect against negative values (happens when interface resets)
        if [ "$RX_SPEED" -lt 0 ]; then
            RX_SPEED=0
        fi

        # Convert to human readable format
        if [ "$RX_SPEED" -gt 1048576 ]; then
            # MB/s
            SPEED_LABEL=$(echo "scale=1; $RX_SPEED / 1048576" | bc | awk '{printf "%.1f MB/s", $1}')
        elif [ "$RX_SPEED" -gt 1024 ]; then
            # KB/s
            SPEED_LABEL=$(echo "scale=0; $RX_SPEED / 1024" | bc | awk '{printf "%d KB/s", $1}')
        else
            SPEED_LABEL="0 KB/s"
        fi

        # Save current stats for next iteration
        echo "$CURRENT_TIME:$CURRENT_RX:$CURRENT_TX" > "$STATS_FILE"
    fi
fi

# Update sketchybar item
sketchybar --set wifi icon="$WIFI_ICON" label="$SPEED_LABEL"
