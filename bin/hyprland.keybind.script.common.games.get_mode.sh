#!/bin/bash
window_title=$(hyprctl activewindow -j | jq '.title')
window_class=$(hyprctl activewindow -j | jq '.class')
waydroid_adb=$(cat /tmp/z.waydroid | head -n 1)
waydroid_game=$(cat /tmp/z.waydroid | tail -n 1)

if [[ "${window_class}" == "Waydroid" || "${window_class}" == *"waydroid"* ]]; then
  if [[ -f "/tmp/z.arknights.waydroid" ]]; then
    output=$(cat /tmp/z.arknights.waydroid)
    notify-send $output
  elif [[ -n "${waydroid_game}" ]]; then
    echo "Arknights \"Initial\"" > /tmp/z.arknights.waydroid
    output=$(cat /tmp/z.arknights.waydroid)
    notify-send $output
  fi
fi

