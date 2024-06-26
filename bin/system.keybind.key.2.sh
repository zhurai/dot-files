#!/bin/bash

. ~/.bin/system.keybind.scripts.games.mode.sh

KEY="2"

. ~/.bin/system.keybind.common.sh

# Waydroid
if [[ "$CLASS_SUBTYPE" == *"Android"* ]] then
  
  . ~/.bin/system.keybind.common.android.sh

# Other
else
  
  echo "Unknown Player/Game Type"
  exit
  
fi
