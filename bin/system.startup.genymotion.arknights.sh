#!/bin/bash

GAME="Arknights"
GENYMOTIONNAME=$(echo ${GAME} | tr -d " \t\n\r")
APKPKG="com.YoStarEN.Arknights"

. ~/.bin/system.startup.genymotion.sh

main
