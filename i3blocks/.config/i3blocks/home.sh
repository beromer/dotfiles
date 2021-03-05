#!/bin/bash

disk=$(df -h /home | awk ' /[0-9]/ {print $4}')

echo "[<span foreground='#a89984'>S·${disk}</span>]"

exit 0

