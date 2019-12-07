#!/usr/bin/env sh

export BROWSER=firefox
export EDITOR=nvim
export MANPAGER="nvim -c 'set ft=man' -"
export PDF=zathura
export PLAYER=mpv
export TERMINAL=st

export FZF_DEFAULT_COMMAND="find . -type f ! -path '*/\.git/*' ! -path '*/tex/*' ! -path '*/\.idea/*' ! -path '*/__pycache__/*' ! -iname 'tags' | sed 's/^.\///'"
export FZF_DEFAULT_OPTS="--cycle --multi --reverse --tabstop=4 --color=bg+:-1,fg+:-1,border:#000000,hl:#a3be8c,prompt:#5e81ac,pointer:#bf616a,marker:#ebcb8b,info:#88c0d0"

export CONDARC=~/.config/condarc
export GNUPGHOME=~/.config/gnupg
export INPUTRC=~/.config/inputrc
export LESSHISTFILE=~/.cache/lesshst
export PYLINTRC=~/.config/pylintrc
export TMUXRC=$HOME/.config/tmux.conf
export _JAVA_AWT_WM_NONREPARENTING=1

export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWUPSTREAM="auto"

[ "$(tty)" = "/dev/tty1" ] && [ "$(whoami)" != "root" ] && sx
