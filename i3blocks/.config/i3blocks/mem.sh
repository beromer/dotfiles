#!/bin/bash

mem=$(free -mh | awk '/Mem/ {print $3}')

echo "[<span foreground='#a89984'>M·${mem}</span>]"

exit 0
