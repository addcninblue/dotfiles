#!/usr/bin/env bash

ICON=""
MAX_BRIGHTNESS=$(cat /sys/class/backlight/intel_backlight/max_brightness)
CURR_BRIGHTNESS=$(cat /sys/class/backlight/intel_backlight/brightness)
# echo $MAX_BRIGHTNESS
# echo $CURR_BRIGHTNESS
# echo $ICON $(($CURR_BRIGHTNESS * 100/$MAX_BRIGHTNESS))
echo $(($CURR_BRIGHTNESS * 100/$MAX_BRIGHTNESS))
