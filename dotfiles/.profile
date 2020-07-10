#!/usr/bin/env sh

export PATH=$HOME/.local/bin:$PATH
export XDG_CONFIG_HOME=$HOME/.config

export BROWSER=firefox
export EDITOR=nvim
export MANPAGER="$EDITOR -c 'set ft=man' -"
export TERMINAL=st

export FZF_DEFAULT_COMMAND="ffind -type f"
export FZF_DEFAULT_OPTS="--cycle --multi --reverse --tabstop=4 --no-info --color=bg+:-1,fg+:-1,border:16,hl:1,hl+:1,prompt:4,pointer:2,marker:3,info:8"

export GNUPGHOME=$XDG_CONFIG_HOME/gnupg
export GTK2_RC_FILES=$XDG_CONFIG_HOME/gtk-2.0/settings.ini
export INPUTRC=$XDG_CONFIG_HOME/inputrc
export IPYTHONDIR=$XDG_CONFIG_HOME/ipython
export LESSHISTFILE=$HOME/.cache/lesshst
export PYLINTHOME=$HOME/.cache/pylint
export PYLINTRC=$XDG_CONFIG_HOME/pylintrc
export PYTHONSTARTUP=$XDG_CONFIG_HOME/pythonrc.py

export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWUPSTREAM="auto"

[ "$(tty)" = "/dev/tty1" ] && [ "$(whoami)" != "root" ] && sx
