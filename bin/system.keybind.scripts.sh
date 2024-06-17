#!/bin/bash

DE=${XDG_CURRENT_DESKTOP}

if [[ "$DE" == "Hyprland" ]] then
  
  TITLE=$(hyprctl activewindow -j | jq '.title')
  CLASS=$(hyprctl activewindow -j | jq '.class')
  
elif [[ "$DE" == "sway" ]] then
  
  TITLE=$(swaymsg -t get_tree | jq '.. | (.nodes? // empty)[] | select(.focused==true).name')
  APPID=$(swaymsg -t get_tree | jq '.. | (.nodes? // empty)[] | select(.focused==true).app_id')
  
  if [[ "$APPID" == "null" ]] then
    
    CLASS=$(swaymsg -t get_tree | jq '.. | (.nodes? // empty)[] | select(.focused==true).window_properties.class')
    
  else
    
    CLASS="$APPID"
    
  fi
  
else
  
  echo "Unknown Environment"
  exit
  
fi
