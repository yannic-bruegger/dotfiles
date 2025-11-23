#!/usr/bin/env bash

# Verzeichnis mit Wallpapers
WALLPAPER_DIR="$HOME/dotfiles/wallpapers"

# State-Datei für aktuellen Index
STATE_FILE="$HOME/.cache/swww_current_wallpaper"

# Alle Bilddateien finden (gif, jpg, png, jpeg)
mapfile -t WALLPAPERS < <(find "$WALLPAPER_DIR" -type f \( -iname "*.gif" -o -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) | sort)

# Anzahl der Wallpapers
TOTAL=${#WALLPAPERS[@]}

if [ $TOTAL -eq 0 ]; then
    echo "Keine Wallpapers in $WALLPAPER_DIR gefunden!"
    exit 1
fi

# Falls der Daemon noch nicht läuft, starte ihn
if ! pgrep -x "swww-daemon" >/dev/null; then
    swww-daemon &
    sleep 0.5
fi

# Aktuellen Index lesen oder bei 0 starten
if [ -f "$STATE_FILE" ]; then
    CURRENT_INDEX=$(cat "$STATE_FILE")
else
    CURRENT_INDEX=0
fi

# Zum nächsten Wallpaper wechseln
NEXT_INDEX=$(( (CURRENT_INDEX + 1) % TOTAL ))

# Wallpaper setzen mit Transition
swww img "${WALLPAPERS[$NEXT_INDEX]}" \
    --transition-type random \
    --transition-fps 60 \
    --transition-duration 2

# Neuen Index speichern
echo "$NEXT_INDEX" > "$STATE_FILE"

# Optional: Name des aktuellen Wallpapers ausgeben
echo "Wallpaper: $(basename "${WALLPAPERS[$NEXT_INDEX]}")"
