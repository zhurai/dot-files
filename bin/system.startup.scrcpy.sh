#!/bin/bash

export SDL_AUDIODRIVER=pipewire
GAMEFILE=$(echo ${GAME} | tr -d " \t\n\r" | tr '[:upper:]' '[:lower:]')
SERVERFILE=$(echo ${SERVER} | tr -d " \t\n\r" | tr '[:upper:]' '[:lower:]')
TEMPFILE=/tmp/z.scrcpy.${SERVERFILE}.${GAMEFILE}
DE=${XDG_CURRENT_DESKTOP}

TITLE="\"${GAME} - ${SERIAL} - ${SERVER}\""
SCRCPYVARIABLES=$(set | grep "_SCRCPYARG" | sed -r 's|_SCRCPYARG_[A-Za-z]+=||g')

# Stop previous sessions to reboot
stop_sessions() {
  
  # remove temporary file
  rm "${TEMPFILE}"

  # stop sessions
  pkill -f -9 ${SERIAL}
  
}

# Start the new session
start_sessions() {
  
  scrcpy \
    --window-title="${TITLE}" \
    --serial="${SERIAL}" \
    ${SCRCPYVARIABLES}
  
}

# Set up the temporary file
populate_tempfile() {

  # We already know the serial (must be specifically added in this case)
  echo "${SERIAL}" > "${TEMPFILE}"
  
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
