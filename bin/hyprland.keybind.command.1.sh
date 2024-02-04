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
  waydroid_adb=$(cat /tmp/z.waydroid | head -n 1)
  waydroid_game=$(cat /tmp/z.waydroid | tail -n 1)
  if [[ "$waydroid_game" == "Arknights" ]]; then
    ~/.bin/hyprland.keybind.script.waydroid.arknights.raiding.speed.sh
  fi

# If Scrcpy
# elif [ "$window_class" == "scrcpy" ]; then

# If Genymotion
# elif [ "$window_class" == "Genymotion Player" ]; then

fi
