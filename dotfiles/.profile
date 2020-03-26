#!/usr/bin/env sh

export BROWSER=firefox
export EDITOR=nvim
export MANPAGER="nvim -c 'set ft=man' -"
export PLAYER=mpv
export TERMINAL=st
export VIEWER=zathura

export FZF_DEFAULT_COMMAND="find -type f ! -path '*/\.git/*' ! -name '.git' ! -path '*/tex/*' ! -path '*/\.idea/*' ! -path '*/__pycache__/*' ! -iname '*.png' ! -name '*.toc' ! -name '*.fdb_latexmk' ! -name '*.out' ! -name '*.log' ! -name '*.fls' ! -name '*.gz' ! -name '*.tox' ! -name '*.nav' ! -name '*.snm' ! -name '*.aux' ! -name 'tags' ! -name '.' | sed 's/^.\///'"
export FZF_DEFAULT_OPTS="--cycle --multi --reverse --tabstop=4 --no-info --color=bg+:-1,fg+:-1,border:16,hl:1,hl+:1,prompt:4,pointer:2,marker:3,info:8"

export _JAVA_AWT_WM_NONREPARENTING=1
export GNUPGHOME=~/.config/gnupg
export INPUTRC=~/.config/inputrc
export IPYTHONDIR=~/.config/ipython
export LESSHISTFILE=~/.cache/lesshst
export PYLINTHOME=~/.cache/pylint
export PYLINTRC=~/.config/pylintrc
export PYTHONSTARTUP=~/.config/pythonrc.py
export TMUXRC=$HOME/.config/tmux.conf

export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWUPSTREAM="auto"

[ "$(tty)" = "/dev/tty1" ] && [ "$(whoami)" != "root" ] && sx
