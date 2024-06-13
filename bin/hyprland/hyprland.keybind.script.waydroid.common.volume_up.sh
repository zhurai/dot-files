#!/bin/bash
window_title=$(hyprctl activewindow -j | jq '.title')
window_class=$(hyprctl activewindow -j | jq '.class')
waydroid_adb=$(cat /tmp/z.waydroid | head -n 1)
waydroid_game=$(cat /tmp/z.waydroid | tail -n 1)

if [[ "$window_class" == *"Waydroid"* || "$window_class" == *"waydroid"* ]]; then
  if [ -n "$waydroid_adb" ]; then
    adb -s $waydroid_adb shell input keyevent 24
  fi
fi
