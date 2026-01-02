#!/bin/bash
# ----------------------------------------------------- 
# Path to keybindings config file
# ----------------------------------------------------- 
config_file=~/.config/hypr/conf/keybindings.conf
echo "Reading from: $config_file"

# ----------------------------------------------------- 
# Parse keybindings
# ----------------------------------------------------- 
keybinds=$(grep -oP '(?<=bind = ).*' $config_file)
keybinds=$(echo "$keybinds" | sed 's/$mainMod/SUPER/g'|  sed 's/,\([^,]*\)$/ = \1/' | sed 's/, exec//g' | sed 's/^,//g')

# ----------------------------------------------------- 
# Show keybindings in rofi
# ----------------------------------------------------- 
sleep 0.2
rofi -dmenu -i -replace -p "Keybinds" -config ~/dotfiles/rofi/config-compact.rasi <<< "$keybinds"
