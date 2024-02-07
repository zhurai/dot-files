#!/bin/bash

GAME="Pokemon Go"
TEMPFILE=/tmp/z.scrcpy-phone000
rm ${TEMPFILE}
APKPKG="com.nianticlabs.pokemongo"
TYPE="--serial"
SERIAL="47f3c1bf"
TITLE="\"${GAME} - ${SERIAL}\""

MODS="--shortcut-mod=lctrl+lalt"
VIDEOCODEC="h265"
VIDEOENCODER="OMX.qcom.video.encoder.hevc"
VIDEOBITRATE="25M"
STAYAWAKE="--stay-awake"
SCREENOFF="--turn-screen-off"
LEGACYPASTE="--legacy-paste"
#CLOSEPOWEROFF="--power-off-on-close"

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
