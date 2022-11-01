#!/usr/bin/env sh

alttab -bg '#2e3440' -fg "#2e3440" -frame "#434c5e" -d 1 -bw 1 -t 64x64 -i 64x64 &
bstatus -l &
dunst &
monitor
sxhkd &
xbanish &
xkbcomp "$XDG_CONFIG_HOME/xkeymap" "$DISPLAY"

"$BROWSER" &
if tmux has-session; then
    "$TERMINAL" -e tmux attach &
else
    "$TERMINAL" -e tmux new \; splitw -h &
fi
