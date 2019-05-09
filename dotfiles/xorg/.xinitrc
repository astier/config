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

# Config
xmodmap -e "keycode 47 = Return"
xmodmap -e "keycode 133 = odiaeresis"
xmodmap -e "keycode 48 = BackSpace"
xmodmap -e "keycode 135 = adiaeresis"
xset s off -dpms

# Programs
compton -b --vsync --config /dev/null
feh --bg-fill ~/Dropbox/Pictures/30343F.png
firefox &
numlockx
st &
unclutter --timeout 4 --jitter 20 --ignore-scrolling -b

exec dwm
