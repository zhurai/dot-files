#!/bin/bash
curr=$(swaymsg -t get_outputs | jq '.[] | select(.focused==true) | .name' | sed 's|"||g')
output0=$(swaymsg -t get_outputs --raw | jq '.[0].name' -r)
output1=$(swaymsg -t get_outputs --raw | jq '.[1].name' -r)

if [[ "$curr" == "$output0" ]]; then
    swaymsg -rt get_workspaces | jq '.[]|.num' | xargs -I {} swaymsg workspace number {}, move workspace to output $output0
elif [[ "$curr" == "$output1" ]]; then
    swaymsg -rt get_workspaces | jq '.[]|.num' | xargs -I {} swaymsg workspace number {}, move workspace to output $output1
fi

swaymsg 'workspace 0_1' && sleep 1
swaymsg 'workspace 0_2' && sleep 1

