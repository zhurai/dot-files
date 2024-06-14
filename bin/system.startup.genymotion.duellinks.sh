#!/bin/bash

GAME="Duel Links"
GAMEFILE=$(echo ${GAME} | tr -d " \t\n\r" | tr '[:upper:]' '[:lower:]')
GENYMOTIONNAME=$(echo ${GAME} | tr -d " \t\n\r")
APKPKG="jp.konami.duellinks"

. ~/.bin/system.startup.genymotion.sh

main
