#!/usr/bin/env sh

# Terminate already running bar instances
pkill -9 polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch bar1 and bar2
PRIMARY=$(polybar --list-monitors | grep primary | cut -d":" -f1)
SECONDARY=$(polybar --list-monitors | grep -v primary | cut -d":" -f1)
MONITOR=$PRIMARY polybar bottom &
for m in $SECONDARY; do
    MONITOR=$m polybar secondary &
done
# polybar bottom &
