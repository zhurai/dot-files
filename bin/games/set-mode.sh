#!/bin/bash
curr_window=$(swaymsg -t get_tree | jq -r '.. | (.nodes? // empty)[] | select (.pid and .visible) | {name}' | jq '.[]' | sed 's/[",]//g')

if [[ "$curr_window" == *"Arknights"* ]]; then
  if [[ -f "/tmp/zhurai-arknights.tmp" ]]; then
    output=$(cat /tmp/zhurai-arknights.tmp | awk '{$1=""}1' | sed 's/^[[:space:]]*//g' | sed 's/[",]//g')
    if [[ "$output" == *"Initial"* ]]; then
      echo "Arknights \"Farming\"" > /tmp/zhurai-arknights.tmp
    elif [[ "$output" == *"Farming"* ]]; then
      echo "Arknights \"Raiding-Standard\"" > /tmp/zhurai-arknights.tmp
    elif [[ "$output" == *"Raiding-Standard"* ]]; then
      echo "Arknights \"Raiding-Alternate\"" > /tmp/zhurai-arknights.tmp
    elif [[ "$output" == *"Raiding-Alternate"* ]]; then
      echo "Arknights \"Initial\"" > /tmp/zhurai-arknights.tmp
    fi
    notify-send $(cat /tmp/zhurai-arknights.tmp | sed 's/^[[:space:]]*//g' | sed 's/[",]//g')
  else
    echo "Arknights \"Initial\"" > /tmp/zhurai-arknights.tmp
  fi
#elif [[ "$curr_window" == "Girls Frontline ]]; then
fi

