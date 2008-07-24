#!/bin/sh

HOME="/home/takatoshi"
APP_DIR="$HOME/app/ero-downloader"
TMP="$APP_DIR/tmp"
SHARE="/var/share/av/tmp"

cd "$APP_DIR"
scripts/fetch_douga_url.pl --debug > logs/fetch_douga_url.log 2>&1
scripts/downloader.pl --dir "$TMP" > logs/downloader.log 2>&1

cd "$TMP"
unzip -qn "*.zip"
mv *.rm $SHARE
rm *

