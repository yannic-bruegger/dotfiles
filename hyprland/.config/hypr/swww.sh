#!/usr/bin/env bash

# Falls der Daemon noch nicht läuft, starte ihn
if ! pgrep -x "swww-daemon" >/dev/null; then
    swww-daemon &
    sleep 0.5  # kleine Pause, damit er ready ist
fi

# Setze das erste Wallpaper beim Start
~/.config/hypr/swww-next.sh

