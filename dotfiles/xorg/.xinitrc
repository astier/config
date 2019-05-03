#!/usr/bin/env bash

# Merge in defaults and keymaps
XINIT=/etc/X11/xinit

sysresources=$XINIT/.Xresources
[[ -f $sysresources ]] && xrdb -merge $sysresources

sysmodmap=$XINIT/.Xmodmap
[[ -f $sysmodmap ]] && xmodmap $sysmodmap

[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

# Start programs
XINITRC=$XINIT/xinitrc.d
if [ -d $XINITRC ] ; then
	for f in "$XINITRC"/?*.sh ; do
		[ -x "$f" ] && . $f
	done
	unset f
fi

# Start programs
compton -b --backend glx --vsync --config /dev/null
feh --bg-fill ~/Dropbox/Pictures/30343F.png
numlockx
st &
unclutter --timeout 4 --jitter 20 --ignore-scrolling -b
xset s off -dpms

sleep 1 && [[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap &
exec dwm
