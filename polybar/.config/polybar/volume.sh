# Find the running sink. Note that this differs from the Default sink.
# `pactl list` lists all sinks
# `awk -v ...` filters out paragraphs that have `RUNNING` in it
# `sed ...` gets the sink number from that paragraph
SINK=$(pactl list | awk -v RS= "/RUNNING/" | sed -nr "s/Sink #([0-9]*)/\1/p")
if [[ $1 == "UP" ]]; then
	pactl set-sink-volume $SINK +10%
elif [[ $1 == "DOWN" ]]; then
	pactl set-sink-volume $SINK -10%
elif [[ $1 == "MUTE" ]]; then
	pactl set-sink-mute $SINK toggle
fi
