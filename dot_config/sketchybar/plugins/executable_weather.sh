#!/bin/bash

# Get weather data from wttr.in
# You can change the location by setting LOCATION variable
LOCATION="Agoura+Hills,CA"  # Set to your specific location

# Fetch weather data
WEATHER_JSON=$(curl -s "wttr.in/${LOCATION}?format=j1")

if [ $? -eq 0 ] && [ -n "$WEATHER_JSON" ]; then
    # Parse temperature and condition
    TEMPERATURE=$(echo "$WEATHER_JSON" | jq -r '.current_condition[0].temp_F')
    CONDITION=$(echo "$WEATHER_JSON" | jq -r '.current_condition[0].weatherDesc[0].value')
    
    # Map weather conditions to SF Symbols
    case "$CONDITION" in
        *[Cc]lear*|*[Ss]unny*)
            ICON="􀆮"  # sun.max
            ;;
        *[Cc]loud*)
            ICON="􀇔"  # cloud
            ;;
        *[Rr]ain*|*[Dd]rizzle*)
            ICON="􀇅"  # cloud.rain
            ;;
        *[Tt]hunder*|*[Ss]torm*)
            ICON="􀇟"  # cloud.bolt.rain
            ;;
        *[Ss]now*|*[Ff]lur*)
            ICON="􀇗"  # cloud.snow
            ;;
        *[Ff]og*|*[Mm]ist*|*[Hh]aze*)
            ICON="􀇋"  # cloud.fog
            ;;
        *[Pp]artly*)
            ICON="􀇕"  # cloud.sun
            ;;
        *[Oo]vercast*)
            ICON="􀇃"  # smoke
            ;;
        *)
            ICON="􀇤"  # thermometer
            ;;
    esac
    
    # Update sketchybar
    sketchybar --set "$NAME" \
        icon="$ICON" \
        label="${TEMPERATURE}°F"
else
    # Fallback if weather fetch fails
    sketchybar --set "$NAME" \
        icon="􀇤" \
        label="--°"
fi

