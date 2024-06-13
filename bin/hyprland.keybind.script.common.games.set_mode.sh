#!/bin/bash
window_title=$(hyprctl activewindow -j | jq '.title')
window_class=$(hyprctl activewindow -j | jq '.class')
waydroid_adb=$(cat /tmp/z.waydroid | head -n 1)
waydroid_game=$(cat /tmp/z.waydroid | tail -n 1)
window_game=$(hyprctl activewindow -j | jq '.title' | sed 's|"||g' | awk '{print $1}')
game_adb=$(gmtool admin list | grep ${window_game} | awk '{print $3}')
ARKNIGHTS_WAYDROID_CONFIG="/tmp/z.arknights.waydroid"
ARKNIGHTS_GENYMOTION_CONFIG="/tmp/z.arknights.genymotion"

if [[ "${window_class}" == *"Waydroid"* || "${window_class}" == *"waydroid"* ]]; then
  if [[ "${waydroid_game}" == *"Arknights"* ]]; then
    if [[ ! -f "$ARKNIGHTS_WAYDROID_CONFIG" ]]; then
      echo "Arknights Initial" > $ARKNIGHTS_WAYDROID_CONFIG
      game=$(cat $ARKNIGHTS_WAYDROID_CONFIG | cut -f 1 -d ' ')
      mode=$(cat $ARKNIGHTS_WAYDROID_CONFIG | cut -f 2- -d ' ')
      notify-send "${game}" "${mode}"
      exit
    fi

    game=$(cat $ARKNIGHTS_WAYDROID_CONFIG | cut -f 1 -d ' ')
    mode=$(cat $ARKNIGHTS_WAYDROID_CONFIG | cut -f 2- -d ' ')
    case "$mode" in
      "Initial")
        sed -i 's/Initial/Farming/' $ARKNIGHTS_WAYDROID_CONFIG
        ;;
      "Farming")
        sed -i 's/Farming/Raiding1/' $ARKNIGHTS_WAYDROID_CONFIG
        ;;
      "Raiding1")
        sed -i 's/Raiding1/Raiding2/' $ARKNIGHTS_WAYDROID_CONFIG
        ;;
      "Raiding2")
        sed -i 's/Raiding2/Initial/' $ARKNIGHTS_WAYDROID_CONFIG
        ;;
    esac      
        
    game=$(cat /tmp/z.arknights.waydroid | cut -f 1 -d ' ')
    mode=$(cat /tmp/z.arknights.waydroid | cut -f 2- -d ' ')
    notify-send "${game}" "${mode}"
  fi
fi


if [[ "$window_class" == *"Genymotion"* ]]; then
  if [[ "$window_game" == *"Arknights"* ]]; then
    if [[ ! -f "$ARKNIGHTS_GENYMOTION_CONFIG" ]]; then
      echo "Arknights Initial" > $ARKNIGHTS_GENYMOTION_CONFIG
      game=$(cat $ARKNIGHTS_GENYMOTION_CONFIG | cut -f 1 -d ' ')
      mode=$(cat $ARKNIGHTS_GENYMOTION_CONFIG | cut -f 2- -d ' ')
      notify-send "${game}" "${mode}"
      exit
    fi

    game=$(cat $ARKNIGHTS_GENYMOTION_CONFIG | cut -f 1 -d ' ')
    mode=$(cat $ARKNIGHTS_GENYMOTION_CONFIG | cut -f 2- -d ' ')
    case "$mode" in
      "Initial")
        sed -i 's/Initial/Farming/' $ARKNIGHTS_GENYMOTION_CONFIG
        ;;
      "Farming")
        sed -i 's/Farming/Raiding1/' $ARKNIGHTS_GENYMOTION_CONFIG
        ;;
      "Raiding1")
        sed -i 's/Raiding1/Raiding2/' $ARKNIGHTS_GENYMOTION_CONFIG
        ;;
      "Raiding2")
        sed -i 's/Raiding2/Initial/' $ARKNIGHTS_GENYMOTION_CONFIG
        ;;
    esac      
        
    game=$(cat /tmp/z.arknights.genymotion | cut -f 1 -d ' ')
    mode=$(cat /tmp/z.arknights.genymotion | cut -f 2- -d ' ')
    notify-send "${game}" "${mode}"
  fi
fi
