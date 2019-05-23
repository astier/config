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
xset s off -dpms

# Programs
b -l &
compton -b --backend glx --vsync --config /dev/null
(firefox &)
numlockx
(st &)
unclutter --timeout 4 --jitter 20 --ignore-scrolling -b

exec dwm
