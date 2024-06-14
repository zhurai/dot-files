#!/bin/bash

GAME="Girls Frontline"
GAMEFILE=$(echo ${GAME} | tr -d " \t\n\r" | tr '[:upper:]' '[:lower:]')
GENYMOTIONNAME=$(echo ${GAME} | tr -d " \t\n\r")
APKPKG="com.sunborn.girlsfrontline.en"
UUID="f865c69e-cddc-48cb-aace-80d414060be1"

. ~/.bin/system.startup.genymotion.sh

main
