#!/usr/bin/env sh

cycle_or_tile() {
    client_count="$(herbstclient get_attr tags.focus.tiling.root."$1".client_count)"
    algorithm="$(herbstclient get_attr tags.focus.tiling.root."$1".algorithm)"
    if [ -n "$2" ]; then
        herbstclient cycle "$2"1
    elif [ "$client_count" -eq 2 ]; then
        if [ "$algorithm" = "max" ]; then
            herbstclient cycle 1
        else
            herbstclient set_layout max
        fi
    elif [ "$algorithm" = "max" ]; then
        herbstclient set_layout vertical
    else
        herbstclient set_layout max
    fi
}

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
