#!/bin/bash

# Waydroid
if [[ "$CLASS_SUBTYPE" == *"Android"* ]] then
  
  . ~/.bin/system.keybind.common.android.sh

# Other
else
  
  echo "Unknown Player/Game Type"
  
fi

