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

numlockx
setxkbmap -option caps:swapescape
compton &
xbanish &

while true; do
	feh --randomize --bg-fill ~/Dropbox/Pictures/Wallpapers/
	sleep 600
done &

while true; do
	dstatus
	sleep 60
done &

exec dwm
