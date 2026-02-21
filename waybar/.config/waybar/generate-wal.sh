#!/bin/bash

# ================================================
# generate-wal.sh
# Aplica as cores do pywal no waybar, bordas do
# hyprland e tema do rofi
# ================================================

COLORS="$HOME/.cache/wal/colors.sh"

if [ ! -f "$COLORS" ]; then
    echo "Arquivo de cores não encontrado: $COLORS"
    exit 1
fi

source "$COLORS"

# -----------------------------------------------
# Atualiza o colors-pywal.css do waybar
# -----------------------------------------------

{
echo "/* Waybar Colors - gerado pelo pywal - nao edite */"
echo "@define-color background ${background};"
echo "@define-color foreground ${foreground};"
echo "@define-color color0 ${color0};"
echo "@define-color color1 ${color1};"
echo "@define-color color2 ${color2};"
echo "@define-color color3 ${color3};"
echo "@define-color color4 ${color4};"
echo "@define-color color5 ${color5};"
echo "@define-color color6 ${color6};"
echo "@define-color color7 ${color7};"
echo "@define-color color8 ${color8};"
echo "@define-color color9 ${color9};"
echo "@define-color color10 ${color10};"
echo "@define-color color11 ${color11};"
echo "@define-color color12 ${color12};"
echo "@define-color color13 ${color13};"
echo "@define-color color14 ${color14};"
echo "@define-color color15 ${color15};"
} > "$HOME/.config/waybar/colors-pywal.css"

# -----------------------------------------------
# Atualiza bordas do hyprland
# -----------------------------------------------

ACTIVE=$(echo "$color4" | tr -d '#')
INACTIVE=$(echo "$color8" | tr -d '#')

hyprctl keyword general:col.active_border "rgba(${ACTIVE}ff)"
hyprctl keyword general:col.inactive_border "rgba(${INACTIVE}44)"

# -----------------------------------------------
# Gera o tema do rofi
# -----------------------------------------------

python3 "$HOME/.config/waybar/wal-rofi.py"

# -----------------------------------------------
# Recarrega o waybar
# -----------------------------------------------

pkill waybar
sleep 0.3
waybar &
