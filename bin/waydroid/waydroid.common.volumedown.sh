#!/bin/bash
curr_window=$(swaymsg -t get_tree | jq -r '.. | (.nodes? // empty)[] | select (.pid and .visible) | {name}' | jq '.[]' | sed 's/[",]//g')
title=$(swaymsg -t get_tree | grep Waydroid | grep name | awk '{$1=""}1' | sed 's/^[[:space:]]*//g' | sed 's/[",]//g')
adb_device=$(tail -n10 /tmp/z.waydroid.epicseven | grep  "connected to"  | tail -n1 | sed 's/connected to //g')

if [[ "$curr_window" == "$title" ]]; then
  if [ -n "$adb_device" ]; then
    adb -s $adb_device shell input keyevent 25
  fi
fi
