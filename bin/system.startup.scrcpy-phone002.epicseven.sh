#!/bin/bash

GAME="Epic Seven"
TEMPFILE=/tmp/z.scrcpy-phone002
rm ${TEMPFILE}
APKPKG="com.stove.epic7.google"
TYPE="--serial"
SERIAL="3446573236453498"
TITLE="\"${GAME} - ${SERIAL}\""

MODS="--shortcut-mod=lctrl+lalt"
VIDEOCODEC="h264"
VIDEOENCODER="OMX.qcom.video.encoder.avc"
VIDEOBITRATE="25M"
STAYAWAKE="--stay-awake"
SCREENOFF="--turn-screen-off"
LEGACYPASTE="--legacy-paste"
CLOSEPOWEROFF="--power-off-on-close"

# make sure any previous sessions are stopped
pkill -f -9 ${SERIAL}
sleep 1

# start a new session
scrcpy --window-title="${TITLE}" ${TYPE}="${SERIAL}" --video-codec="${VIDEOCODEC}" --video-encoder="${VIDEOENCODER}" --video-bit-rate="${VIDEOBITRATE}" ${STAYAWAKE} ${MODS} ${SCREENOFF} ${LEGACYPASTE} ${CLOSEPOWEROFF} &
sleep 1

# System seems to have started fully by now
echo "${SERIAL}" > ${TEMPFILE}
echo "${GAME}" >> ${TEMPFILE}
sleep 1
adb -s ${SERIAL} shell monkey -p ${APKPKG} -c android.intent.category.LAUNCHER 1
