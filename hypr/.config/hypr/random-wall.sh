#!/bin/bash

# ================================================
# random-wall.sh
# Troca o wallpaper aleatoriamente e gera esquema
# de cores com pywal
# Pasta de wallpapers: ~/Wallpapers
# ================================================

WALL_DIR="$HOME/Wallpapers"

# Verifica se a pasta existe
if [ ! -d "$WALL_DIR" ]; then
    notify-send "random-wall" "Pasta $WALL_DIR não encontrada!" --urgency=critical
    exit 1
fi

# Pega uma imagem aleatória da pasta (suporta jpg, jpeg, png, webp)
WALL=$(find "$WALL_DIR" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) | shuf -n 1)

# Verifica se encontrou alguma imagem
if [ -z "$WALL" ]; then
    notify-send "random-wall" "Nenhuma imagem encontrada em $WALL_DIR" --urgency=critical
    exit 1
fi

# Salva o wallpaper escolhido para restaurar no próximo boot
echo "$WALL" > "$HOME/.cache/wal/last-wallpaper"

# Aplica o wallpaper com swww (com transição suave)
swww img "$WALL" \
    --transition-type grow \
    --transition-pos center \
    --transition-duration 1.5 \
    --transition-fps 60

# Gera o esquema de cores com pywal
wal -i "$WALL" -n -q

# Recarrega o waybar com as novas cores
~/.config/waybar/generate-wal.sh

# Recarrega o hyprlock com as novas cores (se o arquivo de template existir)
if [ -f "$HOME/.config/hypr/hyprlock-wal.sh" ]; then
    bash "$HOME/.config/hypr/hyprlock-wal.sh"
fi

# Notifica o nome da imagem aplicada
WALL_NAME=$(basename "$WALL")
notify-send "🎨 Wallpaper" "$WALL_NAME" --urgency=low -t 2000

