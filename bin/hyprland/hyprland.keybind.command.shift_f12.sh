#!/bin/bash

# Confirm we are on Hyprland
if [ "$XDG_CURRENT_DESKTOP" != "Hyprland" ]; then
  exit
fi

AUDIODEVICENAME=$(pactl list | grep Source -A 10 | grep AT2020 | grep Name | awk '{print $2}')
pactl set-source-mute $AUDIODEVICENAME toggle
