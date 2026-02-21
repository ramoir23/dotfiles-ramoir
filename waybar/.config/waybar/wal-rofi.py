#!/usr/bin/env python3

import os
import sys

colors_path = os.path.expanduser("~/.cache/wal/colors.sh")
output_path = os.path.expanduser("~/.config/rofi/wal.rasi")

# Lê as cores do pywal
colors = {}
with open(colors_path) as f:
    for line in f:
        line = line.strip()
        if "=" in line and not line.startswith("#") and not line.startswith("export"):
            key, val = line.split("=", 1)
            colors[key.strip()] = val.strip().strip("'\"")

def hex_to_rgb(h):
    h = h.lstrip("#")
    return int(h[0:2],16), int(h[2:4],16), int(h[4:6],16)

bg   = colors.get("background", "#1a1a1a")
fg   = colors.get("foreground", "#ffffff")
c0   = colors.get("color0", "#1a1a1a")
c1   = colors.get("color1", "#333333")
c4   = colors.get("color4", "#888888")
c8   = colors.get("color8", "#555555")

r0,g0,b0 = hex_to_rgb(c0)
r1,g1,b1 = hex_to_rgb(c1)

theme = f"""/* wal.rasi - gerado pelo pywal - nao edite */

* {{
    background-col:  rgba({r0}, {g0}, {b0}, 0.93);
    foreground-col:  {fg};
    accent-col:      {c4};
    urgent-col:      {c1};
    selected-bg:     {c4};
    selected-fg:     {c0};
    hover-col:       rgba({r1}, {g1}, {b1}, 0.35);
    input-bg:        rgba({r0}, {g0}, {b0}, 0.80);
    placeholder-col: {c8};
}}

window {{
    background-color: @background-col;
    border:           2px;
    border-color:     @accent-col;
    border-radius:    10px;
    padding:          12px;
    width:            480px;
}}

mainbox {{
    background-color: transparent;
    spacing:          8px;
}}

inputbar {{
    background-color: @input-bg;
    border-radius:    8px;
    padding:          8px 12px;
    spacing:          8px;
    children:         [ prompt, entry ];
}}

prompt {{
    background-color: transparent;
    text-color:       @accent-col;
    font:             "JetBrainsMono Nerd Font 13";
}}

entry {{
    background-color:  transparent;
    text-color:        @foreground-col;
    font:              "JetBrainsMono Nerd Font 13";
    placeholder:       "Buscar...";
    placeholder-color: @placeholder-col;
}}

listview {{
    background-color: transparent;
    lines:            8;
    columns:          1;
    spacing:          4px;
}}

element {{
    background-color: transparent;
    border-radius:    6px;
    padding:          8px 12px;
    spacing:          10px;
    children:         [ element-icon, element-text ];
}}

element-icon {{
    background-color: transparent;
    size:             24px;
}}

element-text {{
    background-color: transparent;
    text-color:       @foreground-col;
    font:             "JetBrainsMono Nerd Font 13";
}}

element.selected.normal {{
    background-color: @selected-bg;
}}

element.selected.normal element-text {{
    text-color: @selected-fg;
}}

element.urgent {{
    background-color: @urgent-col;
}}

element normal hover {{
    background-color: @hover-col;
}}
"""

with open(output_path, "w") as f:
    f.write(theme)

print("wal.rasi gerado com sucesso")
