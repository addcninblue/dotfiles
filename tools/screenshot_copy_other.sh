NAME=$(date +%Y-%m-%d_%T)
maim -s | xclip -selection clipboard -t image/png &&
       	notify-send "screenshot taken"
