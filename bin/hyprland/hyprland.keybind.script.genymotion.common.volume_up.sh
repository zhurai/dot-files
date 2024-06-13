#!/bin/bash
window_title=$(hyprctl activewindow -j | jq '.title')
window_class=$(hyprctl activewindow -j | jq '.class')
window_game=$(hyprctl activewindow -j | jq '.title' | sed 's|"||g' | awk '{print $1}')
game_adb=$(gmtool admin list | grep ${window_game} | awk '{print $3}')

if [[ "$window_class" == *"Genymotion"* ]]; then
  if [ -n "$game_adb" ]; then
    adb -s $game_adb shell input keyevent 24
  fi
fi
