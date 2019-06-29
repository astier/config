#!/usr/bin/env bash

# Start programs
XINITRC=$XINIT/xinitrc.d
if [ -d $XINITRC ] ; then
	for f in "$XINITRC"/?*.sh ; do
		[ -x "$f" ] && . $f
	done
	unset f
fi

# Make the return-key easier to reach
xmodmap -e "keycode 47 = Return"
xmodmap -e "keycode 36 = colon"
xmodmap -e "keycode 107 = semicolon"

# Start programs
firefox &
dunst &
st &
unclutter --timeout 4 --jitter 20 --ignore-scrolling -b
xcompmgr &

exec dwm
