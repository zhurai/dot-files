#!/bin/bash

GAME="Epic Seven"
TEMPFILE=/tmp/z.scrcpy-server001-b
rm ${TEMPFILE}
APKPKG="com.stove.epic7.google"
TYPE="--tcpip"
SERIAL="192.168.7.251:5555"
ID="Server001"
TITLE="\"${GAME} - ${SERIAL} - ${ID}\""

MODS="--shortcut-mod=lctrl+lalt"
VIDEOCODEC="h264"
#VIDEOENCODER="OMX.qcom.video.encoder.hevc"
VIDEOBITRATE="15M"
STAYAWAKE="--stay-awake"
#SCREENOFF="--turn-screen-off"
LEGACYPASTE="--legacy-paste"
#CLOSEPOWEROFF="--power-off-on-close"
FPS="--max-fps=30"
SIZE="--max-size=700"
#DISPLAYBUFFER="--display-buffer=200"

# make sure any previous sessions are stopped
pkill -f -9 ${SERIAL}
sleep 1

# start a new session
scrcpy --window-title="${TITLE}" ${TYPE}="${SERIAL}" --video-codec="${VIDEOCODEC}" --video-encoder="${VIDEOENCODER}" --video-bit-rate="${VIDEOBITRATE}" ${STAYAWAKE} ${MODS} ${SCREENOFF} ${LEGACYPASTE} ${CLOSEPOWEROFF} ${SIZE} ${DISPLAYBUFFER} ${FPS} &
sleep 1

# System seems to have started fully by now
echo "${SERIAL}" > ${TEMPFILE}
echo "${GAME}" >> ${TEMPFILE}
sleep 1
adb -s ${SERIAL} shell monkey -p ${APKPKG} -c android.intent.category.LAUNCHER 1

