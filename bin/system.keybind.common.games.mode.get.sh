#!/bin/bash

. ~/.bin/system.keybind.common.games.sh

if [[ "$GAME" == *"Arknights"* ]] then
  
  PROFILE=$(sed -n '3p' "${CONFIG}")

  if [[ -z "$PROFILE" ]] then
    
    echo "Initial" >> "${CONFIG}"
    PROFILE=$(sed -n '3p' "${CONFIG}")

  fi

else
  
  echo "Unknown Player/Game Type"
  exit

fi

notify-send "$GAME" "$PROFILE"
