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
    if [[ "${arknights_status}" == *"Raiding1"* ]]; then
      x1=1181
      x2=1305
      y1=544
      y2=647
      x=$(shuf -i ${x1}-${x2} -n 1)
      y=$(shuf -i ${y1}-${y2} -n 1)
      adb -s $waydroid_adb shell input tap $x $y
    elif [[ "${arknights_status}" == *"Raiding2"* ]]; then
      x1=1163
      x2=1173
      y1=557
      y2=635
      x=$(shuf -i ${x1}-${x2} -n 1)
      y=$(shuf -i ${y1}-${y2} -n 1)
      adb -s $waydroid_adb shell input tap $x $y
    fi
  fi
fi
