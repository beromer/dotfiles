#! /bin/bash

caps=$(xset -q | grep Caps | awk '{ print $4 }')

if [ "${caps}" = "on" ]; then
 echo "<span foreground='red'>CAPS LOCK IS ON</span>"
fi
