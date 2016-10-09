#!/usr/bin/env zsh

current=$(xprop -root -notype 8t "\$$(xprop -root _NET_CURRENT_DESKTOP | awk -F' = ' '{print $2}')\n"  _NET_DESKTOP_NAMES | grep -Eo "([0-9]){1,2}" | head -n1)

case "${1:-next}" in
    "prev") current=$((current-1)) ;;
    "next") current=$((current+1)) ;;
esac

current=$((current % 10))

xdotool key "alt+${current}"
# echo "${current}"
