#!/usr/bin/env sh

[ -r ~/.Xmodmap ] && xmodmap ~/.Xmodmap

bstatus
sxhkd &
exec herbstluftwm -l
