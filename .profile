#!/usr/bin/env sh

SHRC=$HOME/.config/shrc
[ -f "$SHRC" ] && . "$SHRC"

[ "$(tty)" = /dev/tty1 ] && [ "$(whoami)" != root ] && sx
