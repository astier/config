#!/usr/bin/env sh

alttab -bg '#2e3440' -fg "#2e3440" -frame "#434c5e" -d 1 -bw 1 -t 64x64 -i 64x64 &
bstatus -l &
hsetroot -cover "$XDG_CONFIG_HOME/wallpaper"
monitor
sxhkd &
xbanish &
xkbcomp "$XDG_CONFIG_HOME/xkeymap" "$DISPLAY"

while clipnotify; do xsel -bo | xsel -bi; done &

"$BROWSER" &
if tmux has-session; then
    "$TERMINAL" -e tmux attach &
else
    "$TERMINAL" -e tmux new \; splitw -h &
fi
