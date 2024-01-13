#!/bin/bash
curr_window=$(swaymsg -t get_tree | jq -r '.. | (.nodes? // empty)[] | select (.pid and .visible) | {name}' | jq '.[]' | sed 's/[",]//g')
title=$(swaymsg -t get_tree | grep Genymotion | grep Arknights | grep title | awk '{$1=""}1' | sed 's/^[[:space:]]*//g' | sed 's/[",]//g')
adb_device=$(echo $title | cut -d "-" -f 2 | sed 's/^[[:space:]]*//g')

if [[ "$curr_window" == "$title" ]]; then
  if [[ -f "/tmp/zhurai-arknights.tmp" ]]; then
    output=$(cat /tmp/zhurai-arknights.tmp | awk '{$1=""}1' | sed 's/^[[:space:]]*//g' | sed 's/[",]//g')
    if [[ "$output" == *"Raiding-Standard"* ]]; then
      if [ -n "$adb_device" ]; then
        # range 1327,34 -> 1420,99
        x=$(shuf -i 1327-1420 -n 1)
        y=$(shuf -i 34-99 -n 1)
        adb -s $adb_device shell input tap $x $y
      fi
    elif [[ "$output" == *"Raiding-Alternate"* ]]; then
      if [ -n "$adb_device" ]; then
        # range 1327,34 -> 1420,99
        x=$(shuf -i 1327-1420 -n 1)
        y=$(shuf -i 34-99 -n 1)
        adb -s $adb_device shell input tap $x $y
      fi
    fi
  fi
fi
