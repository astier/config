#!/bin/sh

# Merge in defaults and keymaps
sysresources=/etc/X11/xinit/.Xresources
if [ -f $sysresources ]; then
	xrdb -merge $sysresources
fi

sysmodmap=/etc/X11/xinit/.Xmodmap
if [ -f $sysmodmap ]; then
	xmodmap $sysmodmap
fi

userresources=$HOME/.Xresources
if [ -f "$userresources" ]; then
	xrdb -merge "$userresources"
fi

usermodmap=$HOME/.Xmodmap
if [ -f "$usermodmap" ]; then
	xmodmap "$usermodmap"
fi

# Start some nice programs
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
	for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
		[ -x "$f" ] && . "$f"
	done
	unset f
fi

setxkbmap -option caps:swapescape
compton &
xbanish &
feh --bg-fill ~/Dropbox/Pictures/Wallpapers/city-dark.jpg
numlockx

while true; do
	feh --randomize --bg-fill ~/Dropbox/Pictures/Wallpapers/
	sleep 600
done &

while true; do
	DATE=$(date +%H:%M)
	BAT=$(cat /sys/class/power_supply/BAT0/capacity)
	VOL=$(amixer get Master | awk -F'[][]' 'END{ print $2 }')
	xsetroot -name "  $VOL   $BAT%   $DATE "
	sleep 60
done &

# exec cinnamon-session
exec dwm
