#!/bin/bash

export WAYLAND_DISPLAY=wayland-1
export TEMPFILE=/tmp/z.waydroid
export DE=${XDG_CURRENT_DESKTOP}

# Clean/remove temporary file
cleanup_previous() {

  rm ${TEMPFILE}

}

# Stop previous sessions to reboot waydroid
stop_sessions() {

  waydroid session stop 

}

# Start the new session
start_sessions() {

  waydroid session start &

}

# Set up the temporary file
populate_tempfile() {
  
  timeout 1 waydroid log > ${TEMPFILE}
  
  SERIAL=$(cat ${TEMPFILE} | grep ADB | tail -n 1 | grep -oE '((1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])\.){3}(1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])' | sed 's/$/:5555/g')
  echo "${SERIAL}" > ${TEMPFILE}
  
  adb connect ${SERIAL}
  
}

# Start the game
start_game() {

  # Arguments
  GAME=$1
  APK=$2

  # Send info to tempfile
  echo "${GAME}" >> ${TEMPFILE}

  # Launch APK
  if [[ "$APK" != "None" ]] then
    waydroid app launch ${APKPKG}
  fi

}

main() {

  # Arguments
  GAME=${1:"None"}
  APK=${2:"None"}
 
  # Run coroutines
  cleanup_previous

  stop_sessions
  sleep 2

  start_sessions 
  sleep 10

  populate_tempfile
  sleep 40
  
  # If the APK is not declared, then we handle this differently - we still need to 
  if [[ "$APK" == "None" ]] then
    start_game ${GAME}
  else    
    start_game ${GAME} ${APK}
  fi

}
