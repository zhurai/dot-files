#!/bin/bash

GAME="Duel Links"
GENYMOTIONNAME=$(echo ${GAME} | tr -d " \t\n\r")
APKPKG="jp.konami.duellinks"

. ~/.bin/system.startup.genymotion.sh

main
