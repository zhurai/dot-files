#!/bin/bash
curr_window=$(swaymsg -t get_tree | jq -r '.. | (.nodes? // empty)[] | select (.pid and .visible) | {name}' | jq '.[]' | sed 's/[",]//g')

if [[ "$curr_window" == *"Arknights"* ]]; then
  if [[ -f "/tmp/zhurai-arknights.tmp" ]]; then
    output=$(cat /tmp/zhurai-arknights.tmp)
    notify-send $output
  else
    echo "Arknights \"Initial\"" > /tmp/zhurai-arknights.tmp
  fi
#elif [[ "$curr_window" == "Girls Frontline ]]; then
fi

