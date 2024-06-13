window_title=$(hyprctl activewindow -j | jq '.title')
window_class=$(hyprctl activewindow -j | jq '.class')
window_game=$(hyprctl activewindow -j | jq '.title' | sed 's|"||g' | awk '{print $1}')
game_adb=$(gmtool admin list | grep ${window_game} | awk '{print $3}')
arknights_status=$(cat /tmp/z.arknights.genymotion | awk '{$1=""}1' | sed 's/^[[:space:]]*//g' | sed 's/[",]//g')

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
