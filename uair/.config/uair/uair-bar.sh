#!/usr/bin/env sh
# Keep the uair daemon alive for the Waybar custom/uair module.
#
# uair exits after its last session finishes. Without this loop the Waybar
# module would stream from a dead process and freeze on empty output. Respawning
# brings uair back on the first (focus) session, paused — ready to start again.

while true; do
    uair
    sleep 0.3
done
