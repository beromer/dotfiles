#!/bin/bash

load=$(cat /proc/loadavg | awk '{print $1}')

echo "[<span foreground='#a89984'>L·${load}</span>]"

exit 0
