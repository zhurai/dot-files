window_title=$(hyprctl activewindow -j | jq '.title')
window_class=$(hyprctl activewindow -j | jq '.class')
waydroid_adb=$(cat /tmp/z.waydroid | head -n 1)
waydroid_game=$(cat /tmp/z.waydroid | tail -n 1)
arknights_status=$(cat /tmp/z.arknights.waydroid | awk '{$1=""}1' | sed 's/^[[:space:]]*//g' | sed 's/[",]//g')

if [[ "${window_class}" != "Waydroid" && "${window_class}" != *"waydroid"* ]]; then
  exit
fi

if [[ ! -f "/tmp/z.arknights.waydroid" && -n "${waydroid_game}" ]]; then
  echo "Arknights Initial" > /tmp/z.arknights.waydroid
  output=$(cat /tmp/z.arknights.waydroid)
  notify-send $output
  exit
fi

if [[ "${waydroid_game}" == "Arknights" && "${arknights_status}" == *"Raiding"* ]]; then
  if [[ -n "$waydroid_adb" ]]; then
    # back button x2
    adb -s $waydroid_adb shell input keyevent 4
    adb -s $waydroid_adb shell input keyevent 4
  fi
fi

