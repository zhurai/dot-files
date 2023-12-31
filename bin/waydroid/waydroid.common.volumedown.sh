#!/bin/bash
curr_window=$(swaymsg -t get_tree | jq -r '.. | (.nodes? // empty)[] | select (.pid and .visible) | {app_id}' | jq '.[]' | sed 's/[",]//g')
title=$(swaymsg -t get_tree | grep -i Waydroid | grep -vi Representation | grep -vi name | awk '{$1=""}1' | sed 's/^[[:space:]]*//g' | sed 's/[",]//g')
#adb_device=$(cat /tmp/z.waydroid.* | grep  "connected to"  | tail -n1 | sed 's/connected to //g' | sed 's/already //g')
adb_device=$(cat /tmp/z.waydroid.*)

if [[ "$curr_window" == "$title" ]]; then
  if [ -n "$adb_device" ]; then
    adb -s $adb_device shell input keyevent 25
  fi
fi
