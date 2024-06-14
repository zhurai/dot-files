#!/bin/bash

export WAYLAND_DISPLAY=wayland-1
TEMPFILE=/tmp/z.waydroid
DE=${XDG_CURRENT_DESKTOP}

# Stop previous sessions to reboot
stop_sessions() {
  
  # remove temporary file
  rm "${TEMPFILE}"

  # stop sessions
  waydroid session stop 
  
}

# Start the new session
start_sessions() {
  
  waydroid session start &
  
}

# Set up the temporary file
populate_tempfile() {
  
  timeout 1 waydroid log > "${TEMPFILE}"
  
  SERIAL=$(cat "${TEMPFILE}" | grep ADB | tail -n 1 | grep -oE '((1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])\.){3}(1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])' | sed 's/$/:5555/g')
  echo "${SERIAL}" | tee "${TEMPFILE}"
  
  adb connect "${SERIAL}"
  
}

# Start the game
start_game() {
  
  # Show the Waydroid window
  waydroid show-full-ui

  # Send info to tempfile
  echo "${GAME}" >> "${TEMPFILE}"

  # Launch APK if defined
  if [[ -n "${APKPKG}" ]] then
    waydroid app launch "${APKPKG}"
  fi

}

main() {

  # Run coroutines
  stop_sessions
  sleep 2

  start_sessions 
  sleep 10

  populate_tempfile
  sleep 40
  
  start_game 
}
