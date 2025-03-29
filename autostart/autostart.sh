#!/usr/bin/env sh

echo "Xft.dpi: 110" | xrdb -merge

alttab -ns -bg "#2e3440" -fg "#2e3440" -frame "#434c5e" -b 0 -d 1 -bw 1 -t 64x64 -i 64x64 &
bstatus &
sxhkd &
xhidecursor &

"$BROWSER" &

FILE=$XDG_CONFIG_HOME/autostart/local.sh
[ -f "$FILE" ] && . "$FILE"
