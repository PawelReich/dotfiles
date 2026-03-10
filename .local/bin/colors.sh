#!/bin/bash

c_transparent="00000000" 
c_background="#181F21" # Deep, dark slate (easier on eyes than pure pitch black)
c_foreground="#D8E2E6" # Soft, airy off-white for readable text
c_cursor="#FCA7B5"     # Soft cherry blossom pink
c_green="#A7DFB6"      # Bright pastel mint/sprout green
c_blue="#9CD1E8"       # Light spring sky blue
c_black="#101517"      # Darker than bg for terminal contrast
c_red="#F498A5"        # Soft coral/tulip for errors
c_yellow="#F2E1A6"     # Pale daffodil yellow

c_border_active="#9CD1E8"   # Matches the spring sky blue
c_border_inactive="#2A3639" # A muted slate, slightly lighter than the background

c_magenta=$c_red
c_cyan=$c_blue
c_white=$c_foreground

cat <<EOF > ~/.config/kitty/colors.conf
background $c_background
foreground $c_foreground
cursor     $c_cursor
color0     $c_black
color1     $c_red
color2     $c_green
color3     $c_yellow
color4     $c_blue
color5     $c_magenta
color6     $c_cyan
color7     $c_white
color8     $c_black
color9     $c_red
color10    $c_green
color11    $c_yellow
color12    $c_blue
color13    $c_magenta
color14    $c_cyan
color15    $c_white
EOF

# Hyprland
strip_hash() { echo "${1#\#}"; }

cat <<EOF > ~/.config/hypr/colors.conf
\$transparent    = rgba(00000000)
\$background     = rgb($(strip_hash $c_background))
\$foreground     = rgb($(strip_hash $c_foreground))
\$cursor         = rgb($(strip_hash $c_foreground))
\$green          = rgb($(strip_hash $c_green))
\$blue           = rgb($(strip_hash $c_blue))
\$black          = rgb($(strip_hash $c_black))
\$red            = rgb($(strip_hash $c_red))
\$yellow         = rgb($(strip_hash $c_yellow))
EOF

# Eww SCSS
cat <<EOF > ~/.config/eww/colors.scss
\$color_background: $c_background;
\$color_foreground: $c_foreground;
\$color_accent: $c_green;
EOF

# Neovim
cat <<EOF > ~/.config/nvim/lua/colors.lua
return {
    base00 = "$c_background",     -- Default Background
    base01 = "$c_black",          -- Lighter Background (Status bars, line numbers)
    base02 = "$c_border_inactive",-- Selection Background
    base03 = "#555555",           -- Comments, Invisibles
    base04 = "$c_border_active",  -- Dark Foreground
    base05 = "$c_foreground",     -- Default Foreground
    base06 = "$c_white",          -- Light Foreground
    base07 = "$c_white",          -- Light Background
    base08 = "$c_red",           -- Variables, XML Tags
    base09 = "$c_yellow",         -- Integers, Boolean, Constants
    base0A = "$c_yellow",         -- Classes, Search Text Background
    base0B = "$c_green",          -- Strings, Inherited Class
    base0C = "$c_cyan",           -- Support, Regular Expressions
    base0D = "$c_red",            -- Functions, Methods, Headings
    base0E = "$c_blue",           -- Keywords, Storage, Selectors
    base0F = "$c_red"             -- Deprecated
}
EOF
