#!/bin/bash
# Toggle blueman-manager window

if pgrep -x "blueman-manager" > /dev/null; then
    # If running, kill it
    pkill -x "blueman-manager"
else
    # If not running, start it
    blueman-manager &
fi
