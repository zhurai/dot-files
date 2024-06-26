#!/bin/bash

. ~/.bin/system.keybind.scripts.games.mode.sh

KEY="Page_Down"

. ~/.bin/system.keybind.common.sh

# Waydroid
if [[ "$CLASS_SUBTYPE" == *"Android"* ]] then
  
  . ~/.bin/system.keybind.common.android.sh

# Other
else
  
  echo "Unknown Player/Game Type"
  exit
  
fi
