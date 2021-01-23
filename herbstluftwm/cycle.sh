#!/usr/bin/env sh

focused_frame=$(herbstclient get_attr tags.focus.tiling.focused_frame.index)
if [ -z "$focused_frame" ] && [ "$(herbstclient get_attr tags.focus.tiling.focused_frame.client_count)" -gt 1 ]; then
    herbstclient cycle "$1"1
    return
fi

unfocused_frame=0; [ "$focused_frame" -eq 0 ] && unfocused_frame=1
if [ "$(herbstclient get_attr tags.focus.tiling.root."$focused_frame".client_count)" -gt 1 ]; then
    herbstclient cycle "$1"1
elif [ "$(herbstclient get_attr tags.focus.tiling.root."$unfocused_frame".client_count)" -gt 1 ]; then
    herbstclient cycle_frame
    herbstclient cycle "$1"1
fi
