#! /bin/bash

volume=$(pacmd list-sinks|grep -A 15 '* index'| awk '/volume: front/{ print $5 }' | sed 's/[%|,]//g')
mute=$(pacmd list-sinks|grep -A 15 '* index'|awk '/muted:/{ print $2 }')
sinks=$(pactl list sinks)
hasbt=$(echo "$sinks" | grep bluez)
vollvl="${volume}%"

if [ "$mute" = "yes" ]; then
    vollvl="Muted ${vollvl}"
fi

if ! [ -z "$hasbt" ]; then
  echo "<span foreground='#3971ED'>${vollvl}</span>"
else
  echo "${vollvl}"
fi

