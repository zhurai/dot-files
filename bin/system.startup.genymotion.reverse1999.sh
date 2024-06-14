#!/bin/bash

GAME="Reverse1999"
GENYMOTIONNAME=$(echo ${GAME} | tr -d " \t\n\r")
APKPKG="com.bluepoch.m.en.reverse1999"

. ~/.bin/system.startup.genymotion.sh

main
