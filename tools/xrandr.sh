#!/bin/sh

laptop="eDP-1"
# laptop="LVDS-1"

choices="HDMI\nVGA\nlaptop\nlaptop + VGA\nlaptop + HDMI\nManual selection"
chosen=$(echo -e "$choices" | rofi -dmenu -i -lines 4 -bw 20 -eh 2 -width 600 -padding 40)

case "$chosen" in
	HDMI) xrandr --output $laptop --off --output HDMI-1 --auto --output VGA-1 --off;;
	VGA)  xrandr --output $laptop --off --output HDMI-1 --off --output VGA-1 --auto;;
	laptop)  xrandr --output $laptop --auto --output HDMI-1 --off --output VGA-1 --off;;
	"laptop + VGA")  xrandr --output $laptop --auto --output HDMI-1 --off --output VGA-1 --auto --right-of $laptop;;
	"laptop + HDMI")  xrandr --output $laptop --auto --output HDMI-1 --auto --right-of $laptop --output VGA-1 --off;;
	"Manual selection") arandr;;
esac
