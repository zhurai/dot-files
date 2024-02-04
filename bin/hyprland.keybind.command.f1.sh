#!/bin/bash

# This should check the current settings for the game

# Confirm we are on Hyprland
if [ "$XDG_CURRENT_DESKTOP" != "Hyprland" ]; then 
  exit
fi

# Confirm the window class
window_title=$(hyprctl activewindow -j | jq '.title')
window_class=$(hyprctl activewindow -j | jq '.class')

# If Waydroid
if [[ "$window_class" == "Waydroid" || "$window_class" == *"waydroid"* ]]; then
  ~/.bin/hyprland.keybind.script.common.games.get_mode.sh

# If Scrcpy
elif [ "$window_class" == "scrcpy" ]; then
  ~/.bin/hyprland.keybind.script.common.games.get_mode.sh

# If Genymotion
elif [ "$window_class" == "Genymotion Player" ]; then
  ~/.bin/hyprland.keybind.script.common.games.get_mode.sh

fi


