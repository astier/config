#!/usr/bin/env bash

[ -r ~/.Xmodmap ] && xmodmap ~/.Xmodmap

XINITRC=/etc/X11/xinit/xinitrc.d
if [ -d $XINITRC ]; then
	for f in "$XINITRC"/?*.sh; do
		[ -x "$f" ] && . $f
	done
	unset f
fi

bstatus
sxhkd &
exec herbstluftwm
