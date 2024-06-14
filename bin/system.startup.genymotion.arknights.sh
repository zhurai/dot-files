#!/bin/bash

GAME="Arknights"
GAMEFILE=$(echo ${GAME} | tr -d " \t\n\r" | tr '[:upper:]' '[:lower:]')
GENYMOTIONNAME=$(echo ${GAME} | tr -d " \t\n\r")
APKPKG="com.YoStarEN.Arknights"

. ~/.bin/system.startup.genymotion.sh

main
