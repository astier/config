#!/usr/bin/env sh

if [ "$(herbstclient get_attr tags.focus.tiling.focused_frame.client_count)" -gt 2 ] \
    || [ "$(herbstclient get_attr tags.focus.tiling.focused_frame.algorithm)" = "vertical" ]; then
    herbstclient cycle_layout 1 max vertical
else
    herbstclient cycle
fi
