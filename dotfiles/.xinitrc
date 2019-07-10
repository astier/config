#!/usr/bin/env bash

XINITRC=/etc/X11/xinit/xinitrc.d
if [ -d $XINITRC ] ; then
	for f in "$XINITRC"/?*.sh ; do
		[ -x "$f" ] && . $f
	done
	unset f
fi

xmodmap -e "keycode 47 = Return"
xmodmap -e "keycode 36 = colon"
xmodmap -e "keycode 107 = semicolon"

bstatus
firefox &
st &
unclutter --timeout 4 --jitter 20 --ignore-scrolling -b
xcompmgr &
exec dwm
