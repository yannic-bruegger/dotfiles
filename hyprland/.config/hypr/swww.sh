#!/usr/bin/env bash

# Falls der Daemon noch nicht läuft, starte ihn
if ! pgrep -x "swww-daemon" >/dev/null; then
    swww-daemon &
    sleep 0.5  # kleine Pause, damit er ready ist
fi

# Dein Wallpaper setzen
swww img ~/dotfiles/wallpapers/city.gif \
    --transition-type any \
    --transition-fps 60 \
    --transition-duration 2

