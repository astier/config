#!/usr/bin/env bash

[ -r ~/.Xmodmap ] && xmodmap ~/.Xmodmap

bstatus
sxhkd &
exec herbstluftwm -l
