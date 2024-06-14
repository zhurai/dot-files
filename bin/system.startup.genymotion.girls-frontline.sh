#!/bin/bash

GAME="Girls Frontline"
GAMEFILE=$(echo ${GAME} | tr -d " \t\n\r" | tr '[:upper:]' '[:lower:]')
GENYMOTIONNAME=$(echo ${GAME} | tr -d " \t\n\r")
APKPKG="com.sunborn.girlsfrontline.en"

. ~/.bin/system.startup.genymotion.sh

main
