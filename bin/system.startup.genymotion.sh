#!/bin/bash

GAMEFILE=$(echo ${GAME} | tr -d " \t\n\r" | tr '[:upper:]' '[:lower:]')
TEMPFILE=/tmp/z.genymotion.${GAMEFILE}
DE=${XDG_CURRENT_DESKTOP}
UUID=$(gmtool admin list | grep ${GENYMOTIONNAME} | awk -F"|" '{print $3}' | xargs)

# Stop previous sessions to reboot
stop_sessions() {
  
  # remove temporary file
  rm "${TEMPFILE}"

  # stop sessions
  pkill -f -9 ${UUID}
  
}

# Start the new session
start_sessions() {
  
  gmtool admin start "${UUID}"
  
}

# Set up the temporary file
populate_tempfile() {

  if [[ "$DE" == "Hyprland" ]] then
    TITLE=$(hyprctl clients -j | jq .[].title | grep "${GAME}")
  elif [[ "$DE" == "sway" ]] then
    TITLE=$(swaymsg -t get_tree | jq '.. | (.nodes? // empty)[] | select(.focused==true).name')    
  else
    echo "Unknown Environment"
    exit    
  fi
  
  # From the window title, check the serial #
  SERIAL=$(echo ${TITLE} | cut -f 2 -d '-' | awk '{$1=$1};1')
  echo "${SERIAL}" > "${TEMPFILE}"
  
  # TODO: Potentially better to go with gmtool to prevent the need to check this step at least through the DE scripts?
}

# Start the game
start_game() {
  
  # Send info to tempfile
  echo "${GAME}" >> ${TEMPFILE}


  # Launch APK if defined
  if [[ -n "${APKPKG}" ]] then
    adb -s ${SERIAL} shell monkey -p ${APKPKG} -c android.intent.category.LAUNCHER 1
  fi

}

main() {

  # Run coroutines
  stop_sessions
  sleep 5

  start_sessions 
  sleep 30

  populate_tempfile
  sleep 1
  
  start_game 
}
