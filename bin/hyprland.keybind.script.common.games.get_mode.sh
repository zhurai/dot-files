#!/bin/bash
window_title=$(hyprctl activewindow -j | jq '.title')
window_class=$(hyprctl activewindow -j | jq '.class')
waydroid_adb=$(cat /tmp/z.waydroid | head -n 1)
waydroid_game=$(cat /tmp/z.waydroid | tail -n 1)
window_game=$(hyprctl activewindow -j | jq '.title' | sed 's|"||g' | awk '{print $1}')
game_adb=$(gmtool admin list | grep ${window_game} | awk '{print $3}')

if [[ "${window_class}" == *"Waydroid"* || "${window_class}" == *"waydroid"* ]]; then
  if [[ "${waydroid_game}" == *"Arknights"* ]]; then
    if [[ -f "/tmp/z.arknights.waydroid" ]]; then
      game=$(cat /tmp/z.arknights.waydroid | cut -f 1 -d ' ')
      mode=$(cat /tmp/z.arknights.waydroid | cut -f 2- -d ' ')
      notify-send "${game}" "${mode}"
    else
      echo "Arknights Initial" > /tmp/z.arknights.waydroid
      game=$(cat /tmp/z.arknights.waydroid | cut -f 1 -d ' ')
      mode=$(cat /tmp/z.arknights.waydroid | cut -f 2- -d ' ')
      notify-send "${game}" "${mode}"
    fi
  fi

if [[ "$window_class" == *"Genymotion"* ]]; then
  if [[ "$window_game" == *"Arknights"* ]]; then
    if [[ -f "/tmp/z.arknights.genymotion" ]]; then
      game=$(cat /tmp/z.arknights.genymotion | cut -f 1 -d ' ')
      mode=$(cat /tmp/z.arknights.genymotion | cut -f 2- -d ' ')
      notify-send "${game}" "${mode}"
    else
      echo "Arknights Initial" > /tmp/z.arknights.genymotion
      game=$(cat /tmp/z.arknights.genymotion | cut -f 1 -d ' ')
      mode=$(cat /tmp/z.arknights.genymotion | cut -f 2- -d ' ')
      notify-send "${game}" "${mode}"
  fi
fi

fi
