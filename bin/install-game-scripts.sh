#!/bin/bash

mkdir ~/.bin/arknights/
mkdir ~/.bin/games/
mkdir ~/.bin/girlsfrontline/
rm -rv ~/.bin/arknights/*
rm -rv ~/.bin/games/*
rm -rv ~/.bin/girlsfrontline/*

workingdir=$(dirname $(realpath "$0"))/arknights
find $workingdir -maxdepth 1 -type f ! -name "*.md" -exec chmod +x {} \; -exec ln -s {} ~/.bin/arknights \; -exec echo {} \;

workingdir=$(dirname $(realpath "$0"))/games
find $workingdir -maxdepth 1 -type f ! -name "*.md" -exec chmod +x {} \; -exec ln -s {} ~/.bin/games \; -exec echo {} \;

workingdir=$(dirname $(realpath "$0"))/girlsfrontline
find $workingdir -maxdepth 1 -type f ! -name "*.md" -exec chmod +x {} \; -exec ln -s {} ~/.bin/girlsfrontline \; -exec echo {} \;
