#!/usr/bin/env bash

# Merge in defaults and keymaps
XINIT=/etc/X11/xinit

sysresources=$XINIT/.Xresources
[[ -f $sysresources ]] && xrdb -merge $sysresources

sysmodmap=$XINIT/.Xmodmap
[[ -f $sysmodmap ]] && xmodmap $sysmodmap

[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
[[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap

# Start programs
XINITRC=$XINIT/xinitrc.d
if [ -d $XINITRC ] ; then
	for f in "$XINITRC"/?*.sh ; do
		[ -x "$f" ] && . "$f"
	done
	unset f
fi

# Swap ALT-RIGHT/GR with WIN_LEFT
xmodmap -e "keycode 108 = Super_L"
xmodmap -e "keycode 133 = ISO_Level3_Shift"

# Start programs
b -l ~/Dropbox/Pictures/Wallpapers/ &
compton -bf --backend glx --vsync --config /dev/null
# compton -b
numlockx
st &
unclutter --timeout 4 --jitter 20 --ignore-scrolling -b
xset s off -dpms

exec dwm
