#!/bin/bash

GAME="Girls Frontline"
GENYMOTIONNAME=$(echo ${GAME} | tr -d " \t\n\r")
APKPKG="com.sunborn.girlsfrontline.en"

. ~/.bin/system.startup.genymotion.sh

main
