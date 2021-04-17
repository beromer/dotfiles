#! /bin/bash

header="$(date '+%-l:%M %p')"

body="${body}$(date    '+%A, %B %-d')\n"
body="${body}\n"
body="${body}$(date    '+%a, %b %-d, %Y, %H:%M:%S %Z')\n"
body="${body}$(date -u '+%a, %b %-d, %Y, %H:%M:%S %Z')\n"

notify-send -t 5000 "${header}" "${body}"
