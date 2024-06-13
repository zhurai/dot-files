window_title=$(hyprctl activewindow -j | jq '.title')
window_class=$(hyprctl activewindow -j | jq '.class')
window_game=$(hyprctl activewindow -j | jq '.title' | sed 's|"||g' | awk '{print $1}')
game_adb=$(gmtool admin list | grep ${window_game} | awk '{print $3}')
arknights_status=$(cat /tmp/z.arknights.genymotion | awk '{$1=""}1' | sed 's/^[[:space:]]*//g' | sed 's/[",]//g')

if [[ "${window_class}" != *"Waydroid"* && "${window_class}" != *"waydroid"* ]]; then
  exit
fi

if [[ ! -f "/tmp/z.arknights.waydroid" && -n "${waydroid_game}" ]]; then
  echo "Arknights Initial" > /tmp/z.arknights.waydroid
  output=$(cat /tmp/z.arknights.waydroid)
  notify-send $output
  exit
fi

if [[ "${waydroid_game}" == *"Arknights"* && "${arknights_status}" == *"Raiding"* ]]; then
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

if [[ "$window_class" != *"Genymotion"* ]]; then
  exit
fi

if [[ ! -f "/tmp/z.arknights.genymotion" && -n "${window_game}" ]]; then
  echo "Arknights Initial" > /tmp/z.arknights.genymotion
  output=$(cat /tmp/z.arknights.genymotion)
  notify-send $output
  exit
fi

if [[ "${window_game}" == *"Arknights"* ]]; then
  if [[ -n "$game_adb" ]]; then
    # back button
    adb -s $game_adb shell input keyevent 4
  fi
fi
