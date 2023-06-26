#!/usr/bin/env sh

bstatus &
xbanish &
xkbcomp "$XDG_CONFIG_HOME/xkeymap" "$DISPLAY"
