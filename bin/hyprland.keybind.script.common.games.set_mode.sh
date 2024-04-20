#!/bin/bash
window_title=$(hyprctl activewindow -j | jq '.title')
window_class=$(hyprctl activewindow -j | jq '.class')
waydroid_adb=$(cat /tmp/z.waydroid | head -n 1)
waydroid_game=$(cat /tmp/z.waydroid | tail -n 1)

ARKNIGHTS_CONFIG="/tmp/z.arknights.waydroid"

if [[ "${window_class}" == *"Waydroid"* || "${window_class}" == *"waydroid"* ]]; then
  if [[ "${waydroid_game}" == *"Arknights"* ]]; then
    if [[ ! -f "$ARKNIGHTS_CONFIG" ]]; then
      echo "Arknights Initial" > $ARKNIGHTS_CONFIG
      game=$(cat $ARKNIGHTS_CONFIG | cut -f 1 -d ' ')
      mode=$(cat $ARKNIGHTS_CONFIG | cut -f 2- -d ' ')
      notify-send "${game}" "${mode}"
      exit
    fi

    game=$(cat $ARKNIGHTS_CONFIG | cut -f 1 -d ' ')
    mode=$(cat $ARKNIGHTS_CONFIG | cut -f 2- -d ' ')
    case "$mode" in
      "Initial")
        sed -i 's/Initial/Farming/' $ARKNIGHTS_CONFIG
        ;;
      "Farming")
        sed -i 's/Farming/Raiding1/' $ARKNIGHTS_CONFIG
        ;;
      "Raiding1")
        sed -i 's/Raiding1/Raiding2/' $ARKNIGHTS_CONFIG
        ;;
      "Raiding2")
        sed -i 's/Raiding2/Initial/' $ARKNIGHTS_CONFIG
        ;;
    esac      
        
    game=$(cat /tmp/z.arknights.waydroid | cut -f 1 -d ' ')
    mode=$(cat /tmp/z.arknights.waydroid | cut -f 2- -d ' ')
    notify-send "${game}" "${mode}"
  fi
fi
