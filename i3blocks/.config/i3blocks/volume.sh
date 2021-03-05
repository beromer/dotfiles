#! /bin/bash

volume=$(pacmd list-sinks|grep -A 15 '* index'| awk '/volume: front/{ print $5 }' | sed 's/[%|,]//g')
mute=$(pacmd list-sinks|grep -A 15 '* index'|awk '/muted:/{ print $2 }')
sinks=$(pactl list sinks)
hasbt=$(echo "$sinks" | grep bluez)

if ! [ -z "$hasbt" ]; then
volstr="H${volume}%"
else
volstr="${volume}%"
fi

if [ "$mute" = "no" ]; then
    echo "[<span foreground='#b8bb26'>V·${volstr}</span>]"
else
    echo "[<span foreground='#cc241d'>V·${volstr}</span>]"
fi
