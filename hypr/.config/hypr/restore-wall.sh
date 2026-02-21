#!/bin/bash

# ================================================
# restore-wall.sh
# Roda no boot e restaura o último wallpaper usado.
# Se nunca tiver sido definido um, sorteia um da pasta.
# ================================================

CACHE="$HOME/.cache/wal/last-wallpaper"

if [ -f "$CACHE" ] && [ -f "$(cat $CACHE)" ]; then
    IMG=$(cat "$CACHE")
    swww img "$IMG" --transition-type none
    wal -i "$IMG" -n -q
    ~/.config/waybar/generate-wal.sh
else
    # Primeiro uso: sorteia um wallpaper
    bash ~/.config/hypr/random-wall.sh
fi
