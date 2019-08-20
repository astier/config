#!/usr/bin/env bash

if ! pgrep -x dzen2 >/dev/null; then
    geometry=( $(herbstclient monitor_rect 0) )
    herbstclient --idle 2> /dev/null | dzen2 -y "${geometry[3]}" -h 7 -bg '#000000' -fg '#000000'
fi
