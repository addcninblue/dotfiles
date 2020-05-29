#!/usr/bin/env bash

# Specifying the icon(s) in the script
# This allows us to change its appearance conditionally
icon=""

player_status=$(playerctl --player=playerctld status 2> /dev/null)
if [[ $? -eq 0 ]]; then
    metadata="$(playerctl --player=playerctld metadata artist) - $(playerctl --player=playerctld metadata title)"
fi
echo $metadata
echo "hi"

# Foreground color formatting tags are optional
if [[ $player_status = "Playing" ]]; then
    echo "%{F#DFDFDF}$icon $metadata"       # Orange when playing
elif [[ $player_status = "Paused" ]]; then
    echo "%{F#65737E}$icon $metadata"       # Greyed out info when paused
else
    echo ""                 # Greyed out icon when stopped
fi
