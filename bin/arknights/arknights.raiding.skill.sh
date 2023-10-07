#!/bin/bash
curr_window=$(swaymsg -t get_tree | jq -r '.. | (.nodes? // empty)[] | select (.pid and .visible) | {name}' | jq '.[]' | sed 's/[",]//g')
title=$(swaymsg -t get_tree | grep Genymotion | grep Arknights | grep title | awk '{$1=""}1' | sed 's/^[[:space:]]*//g' | sed 's/[",]//g')
adb_device=$(echo $title | cut -d "-" -f 2 | sed 's/^[[:space:]]*//g')

if [[ "$curr_window" == "$title" ]]; then
  if [[ -f "/tmp/zhurai-arknights.tmp" ]]; then
    output=$(cat /tmp/zhurai-arknights.tmp | awk '{$1=""}1' | sed 's/^[[:space:]]*//g' | sed 's/[",]//g')
    if [[ "$output" == *"Raiding-Standard"* ]]; then
      if [ -n "$adb_device" ]; then
        # range 1005,465 -> 1114,542
        x=$(shuf -i 1005-1114 -n 1)
        y=$(shuf -i 465-542 -n 1)
        adb -s $adb_device shell input tap $x $y
      fi
    elif [[ "$output" == *"Raiding-Alternate"* ]]; then
      if [ -n "$adb_device" ]; then
        # range 989,464 -> 1083,533
        x=$(shuf -i 989-1083 -n 1)
        y=$(shuf -i 464-533 -n 1)
        adb -s $adb_device shell input tap $x $y
      fi
    fi
  fi
fi
