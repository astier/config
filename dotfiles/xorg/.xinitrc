#!/usr/bin/env bash

# Merge in defaults and keymaps
XINIT=/etc/X11/xinit
sysresources=$XINIT/.Xresources
[[ -f $sysresources ]] && xrdb -merge $sysresources

sysmodmap=$XINIT/.Xmodmap
[[ -f $sysmodmap ]] && xmodmap $sysmodmap

userresources=$HOME/.Xresources
[[ -f "$userresources" ]] && xrdb -merge "$userresources"

usermodmap=$HOME/.Xmodmap
[[ -f "$usermodmap" ]] && xmodmap "$usermodmap"

# Start some nice programs
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

numlockx
xset s off dpms 0 0 0
compton &
dstatus &
xbanish &

while true; do
	bgm ~/Wallpapers/Cityscapes/
	sleep 900
done &

exec dwm
