#!/usr/bin/env bash

if ! pgrep -x dzen2 >/dev/null; then
    hc() { "${herbstclient_command[@]:-herbstclient}" "$@" ;}
    monitor=${1:-0}
    geometry=( $(hc monitor_rect "$monitor") )
    if [ -z "$geometry" ] ;then
        echo Invalid monitor $monitor
        exit 1
    fi
    x=${geometry[0]}
    y=${geometry[1]}
    panel_width=${geometry[2]}
    panel_height=16
    dzen2 -w ${geometry[2]} -x ${geometry[0]} -y ${geometry[3]} -h 7 -bg '#000000'
fi
