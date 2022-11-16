#!/usr/bin/env sh

alttab -bg '#2e3440' -fg "#2e3440" -frame "#434c5e" -d 1 -bw 1 -t 64x64 -i 64x64 &
bstatus -l &
dunst &
hsetroot -cover "$XDG_CONFIG_HOME/wallpaper"
monitor
sxhkd &
tint2 &
xbanish &
xcompmgr &
xkbcomp "$XDG_CONFIG_HOME/xkeymap" "$DISPLAY"

"$BROWSER" &
"$TERMINAL" -e tmux new -A &
