#!/bin/bash
hyprctl dispatch 'workspace 5'
activewindow=$(hyprctl activewindow | grep title)

while [[ *"$activewindow"* != *"title: Granblue Fantasy - Vivaldi"* ]] do
   # change active window
   hyprctl dispatch 'cyclenext' 
   sleep 0.5

   activewindow=$(hyprctl activewindow | grep title)
done

while [[ *"$activewindow"* == *"title: Granblue Fantasy - Vivaldi"* ]] do
   hyprctl dispatch 'denywindowfromgroup'

   # change active window
   hyprctl dispatch 'cyclenext' 
   sleep 0.5

   activewindow=$(hyprctl activewindow | grep title)
done

hyprctl dispatch 'togglegroup'
sleep 0.5
hyprctl dispatch 'cyclenext' 
sleep 0.5
activewindow=$(hyprctl activewindow | grep title)
while [[ *"$activewindow"* != *"title: Granblue Fantasy - Vivaldi"* ]] do
   echo $activewindow
   hyprctl dispatch 'moveintogroup d'
   sleep 0.5
   activewindow=$(hyprctl activewindow | grep title)
   hyprctl dispatch 'cyclenext' 
   sleep 0.5
done
