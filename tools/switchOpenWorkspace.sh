#!/usr/bin/env zsh
workspaces=($(xprop -root | grep "_NET_DESKTOP_NAMES" | head -n1 | grep -Eo "([0-9]{1,2})"))
workspaces=("${workspaces[@]:1}")
current=$(xprop -root -notype 8t "\$$(xprop -root _NET_CURRENT_DESKTOP | awk -F' = ' '{print $2}')\n"  _NET_DESKTOP_NAMES | grep -Eo "([0-9]){1,2}" | head -n1)

# count is the index of the workspace
count=1;for i in "${workspaces[@]}"; do
	[[ $i == "${current}" ]] && break
	((++count))
done

case "${1:-next}" in
    "prev") count=$((count-1)) ;;
    "next") count=$((count+1)) ;;
esac

count=$((count % ${#workspaces})) #fix when the current workspace is the last one

nextWorkspace=${workspaces[${count}]}
nextWorkspace=$((nextWorkspace % 10))

xdotool key "alt+${nextWorkspace}"
echo "${nextWorkspace}"
