#!/usr/bin/env bash

# Merge in defaults and keymaps
XINIT=/etc/X11/xinit

sysmodmap=$XINIT/.Xmodmap
[[ -f $sysmodmap ]] && xmodmap $sysmodmap

sysresources=$XINIT/.Xresources
[[ -f $sysresources ]] && xrdb -merge $sysresources

[[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap &
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

# Start programs
XINITRC=$XINIT/xinitrc.d
if [ -d $XINITRC ] ; then
	for f in "$XINITRC"/?*.sh ; do
		[ -x "$f" ] && . $f
	done
	unset f
fi

xmodmap -e "keycode 29 = z"
xmodmap -e "keycode 52 = y"
xmodmap -e "keycode 47 = Return"
xmodmap -e "keycode 36 = colon"
xmodmap -e "keycode 107 = semicolon"

compton -b --backend glx --vsync --config /dev/null
feh --bg-fill ~/Dropbox/Pictures/black.jpg
(firefox &)
(st &)
unclutter --timeout 4 --jitter 20 --ignore-scrolling -b
exec dwm
