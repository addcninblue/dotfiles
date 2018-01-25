NAME=$(date +%Y-%m-%d_%T)
maim -s /home/addison/screenshots/$NAME.png &&
	xclip -selection clipboard -t image/png -i /home/addison/screenshots/$NAME.png &&
       	notify-send "screenshot taken"
