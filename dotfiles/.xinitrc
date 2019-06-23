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

# Some GUIs will start with a gray screen when this is not set (see man dwm)
export _JAVA_AWT_WM_NONREPARENTING=1

# Make the return-key easier to reach
xmodmap -e "keycode 47 = Return"
xmodmap -e "keycode 36 = colon"
xmodmap -e "keycode 107 = semicolon"

# Start programs
firefox &
hsetroot
st &
unclutter --timeout 4 --jitter 20 --ignore-scrolling -b
xcompmgr &

exec dwm
