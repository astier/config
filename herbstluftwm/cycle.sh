#!/usr/bin/env sh

[ "$(herbstclient get_attr tags.focus.tiling.root.0.client_count)" -lt 2 ] && return
[ "$(herbstclient get_attr tags.focus.tiling.focused_frame.index)" -eq 1 ] && herbstclient focus l
herbstclient cycle "$1"1
