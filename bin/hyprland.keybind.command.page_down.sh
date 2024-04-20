#!/bin/bash

# This should decrease the volume for games, and ignore all others

# Confirm we are on Hyprland
if [ "$XDG_CURRENT_DESKTOP" != "Hyprland" ]; then 
  exit
fi

# Confirm the window class
window_title=$(hyprctl activewindow -j | jq '.title')
window_class=$(hyprctl activewindow -j | jq '.class')

# If Waydroid
if [[ "$window_class" == *"Waydroid"* || "$window_class" == *"waydroid"* ]]; then
  ~/.bin/hyprland.keybind.script.waydroid.common.volume_down.sh 

# If Scrcpy
elif [ "$window_class" == *"scrcpy"* ]; then
  ~/.bin/hyprland.keybind.script.scrcpy.common.volume_down.sh

# If Genymotion
elif [ "$window_class" == *"Genymotion Player"* ]; then
  ~/.bin/hyprland.keybind.script.genymotion.common.volume_down.sh

fi
