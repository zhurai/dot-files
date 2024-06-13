#!/bin/bash

# This should check the current settings for the game

# Confirm we are on Hyprland
if [ "$XDG_CURRENT_DESKTOP" != "Hyprland" ]; then 
  exit
fi

# Confirm the window class
window_title=$(hyprctl activewindow -j | jq '.title')
window_class=$(hyprctl activewindow -j | jq '.class')
window_game=$(hyprctl activewindow -j | jq '.title' | sed 's|"||g' | awk '{print $1}')

# If Waydroid
if [[ "$window_class" == *"Waydroid"* || "$window_class" == *"waydroid"* ]]; then
  waydroid_adb=$(cat /tmp/z.waydroid | head -n 1)
  waydroid_game=$(cat /tmp/z.waydroid | tail -n 1)
  if [[ "$waydroid_game" == *"Arknights"* ]]; then
    ~/.bin/hyprland.keybind.script.waydroid.arknights.raiding.retreat.sh
  fi

# If Scrcpy
# elif [ "$window_class" == *"scrcpy"* ]; then

# If Genymotion
elif [[ "$window_class" == *"Genymotion Player"* ]]; then
  if [[ "$window_game" == *"Arknights"* ]]; then
    ~/.bin/hyprland.keybind.script.genymotion.arknights.raiding.retreat.sh
  fi

fi
