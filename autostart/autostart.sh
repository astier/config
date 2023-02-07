#!/usr/bin/env sh

xbanish &
xkbcomp "$XDG_CONFIG_HOME/xkeymap" "$DISPLAY"
