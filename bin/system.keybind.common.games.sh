#!/bin/bash

. ~/.bin/system.keybind.common.sh

# Waydroid
if [[ "$CLASS" == *"Waydroid"* || "$CLASS" == *"waydroid"* ]] then
  
  CONFIG="/tmp/z.waydroid"
  ADB=$(sed -n '1p' ${CONFIG})
  GAME=$(sed -n '2p' ${CONFIG})
  
# Genymotion
elif [[ "$CLASS" == *"Genymotion Player"* ]] then
  
  GAMEFILE=$(swaymsg -t get_tree | jq --raw-output '.. | (.nodes? // empty)[] | select(.focused==true).name' | awk -F" - " '{print $1}' | tr '[:upper:]' '[:lower:]')
  CONFIG="/tmp/z.genymotion.${GAMEFILE}"
  ADB=$(sed -n '1p' ${CONFIG})
  GAME=$(sed -n '2p' ${CONFIG})
  
# Scrcpy
elif [[ "$CLASS" == *"scrcpy"* ]] then
  
  GAMEFILE=$(swaymsg -t get_tree | jq --raw-output '.. | (.nodes? // empty)[] | select(.focused==true).name' | awk -F" - " '{print $1}' | tr '[:upper:]' '[:lower:]')
  SERVER=$(swaymsg -t get_tree | jq --raw-output '.. | (.nodes? // empty)[] | select(.focused==true).name' | tr -d '"' | awk -F" - " '{print $3}' | tr '[:upper:]' '[:lower:]')
  CONFIG="/tmp/z.scrcpy.${SERVER}.${GAMEFILE}"
  ADB=$(sed -n '1p' ${CONFIG})
  GAME=$(sed -n '2p' ${CONFIG})

# Other
else
  
  echo "Unknown Player/Game Type"
  exit
  
fi
