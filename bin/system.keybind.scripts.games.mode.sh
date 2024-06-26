#!/bin/bash

. ~/.bin/system.keybind.scripts.games.sh

if [[ "$GAME" == *"Arknights"* ]] then
  
  . ~/.bin/system.keybind.common.arknights.sh
  PROFILE=$(sed -n '3p' "${CONFIG}")
  
  if [[ -z "$PROFILE" ]] then
    
    echo "Initial" >> "${CONFIG}"
    PROFILE=$(sed -n '3p' "${CONFIG}")

  fi

fi

GAME_MODE_ADJUST() {
  
  OLDPROFILE="${PROFILE}"

  for index in "${!PROFILE_LIST[@]}"; do
  
    if [[ "${PROFILE_LIST[$index]}" == "$PROFILE" ]] then
      
      if [[ "$index" == "$((${#PROFILE_LIST[@]}-1))" ]] then
        
        PROFILE="${PROFILE_LIST[0]}"

      else
      
        PROFILE="${PROFILE_LIST[$(($index+1))]}"
      
      fi

      sed -i "s|${OLDPROFILE}|${PROFILE}|" "${CONFIG}"
      break

    fi
  
  done
}

