#!/usr/bin/env sh

export PATH=$HOME/.local/bin:$PATH
export XDG_CACHE_HOME=$HOME/.cache
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CONFIG_DIRS=$XDG_CONFIG_HOME:/etc/xdg:$XDG_CONFIG_DIRS
export XDG_DATA_HOME=$HOME/.local/share
export XDG_DATA_DIRS=$XDG_DATA_HOME:/usr/local/share:/usr/share:$XDG_DATA_DIRS
export XDG_SESSION_TYPE=x11

export BROWSER=firefox
export EDITOR=nvim
export MANPAGER="nvim +Man!"
export OPENER=open
export TERMINAL=st
export VIEWER_IMG=gthumb
export VIEWER_MP3=$BROWSER
export VIEWER_PDF=$BROWSER
export VIEWER_VID=$BROWSER

export CONFIG=$HOME/projects/config
export GNUPGHOME=$XDG_DATA_HOME/gnupg
export GTK2_RC_FILES=$XDG_CONFIG_HOME/gtk-2.0/settings.ini
export INPUTRC=$XDG_CONFIG_HOME/inputrc
export IPYTHONDIR=$XDG_CONFIG_HOME/ipython
export LESSHISTFILE=$XDG_CACHE_HOME/lesshst
export PYLINTHOME=$XDG_CACHE_HOME/pylint
export PYLINTRC=$XDG_CONFIG_HOME/pylintrc
export PYTHONSTARTUP=$XDG_CONFIG_HOME/pythonrc.py
export TERMINFO=$XDG_DATA_HOME/terminfo
export TERMINFO_DIRS=$TERMINFO:/usr/share/terminfo

export FZF_CTRL_T_OPTS="--select-1 --exit-0"
export FZF_DEFAULT_COMMAND="ffind -type f"
export FZF_DEFAULT_OPTS="--cycle --multi --reverse --preview-window border-sharp --tabstop=4 --tiebreak=begin,length,end,index --no-info --color=bg+:-1,fg+:-1,border:16,hl:1,hl+:1,prompt:4,pointer:2,marker:3,info:8"
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWUPSTREAM=auto

SHRC=$XDG_CONFIG_HOME/shrc
[ -r "$SHRC" ] && . "$SHRC"

[ "$(tty)" = /dev/tty1 ] && [ "$(whoami)" != root ] && sx
