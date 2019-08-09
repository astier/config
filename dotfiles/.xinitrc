#!/usr/bin/env sh

xmodmap -e keycode 47 = Return
xmodmap -e keycode 36 = colon
xmodmap -e keycode 107 = semicolon

bstatus
sxhkd &
exec herbstluftwm -l
