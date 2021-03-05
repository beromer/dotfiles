#!/bin/bash

disk=$(df -h /data | awk ' /[0-9]/ {print $4}')

echo "[<span foreground='#a89984'>D·${disk}</span>]"

exit 0

