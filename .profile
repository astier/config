#!/usr/bin/env sh

export PATH="$HOME/.local/bin:$PATH"

export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CONFIG_DIRS="$XDG_CONFIG_HOME:/etc/xdg:$XDG_CONFIG_DIRS"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_DATA_DIRS="$XDG_DATA_HOME:/usr/local/share:/usr/share:$XDG_DATA_DIRS"

export DISPLAY=:1
export XAUTHORITY="$XDG_DATA_HOME/sx/xauthority"

export CONFIG="$HOME/repos/config"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/settings.ini"
export INPUTRC="$XDG_CONFIG_HOME/inputrc"
export IPYTHONDIR="$XDG_CONFIG_HOME/ipython"
export LESSHISTFILE="$XDG_CACHE_HOME/lesshst"
export PYLINTHOME="$XDG_CACHE_HOME/pylint"
export PYLINTRC="$XDG_CONFIG_HOME/pylintrc"
export PYTHONSTARTUP="$XDG_CONFIG_HOME/pythonrc.py"
export TERMINFO="$XDG_DATA_HOME/terminfo"
export TERMINFO_DIRS="$TERMINFO:/usr/share/terminfo"

export BROWSER=firefox
export EDITOR=nvim
export LAUNCHER=open
export MANPAGER="nvim +Man!"
export TERMINAL=alacritty

export FZF_CTRL_T_OPTS="--select-1 --exit-0"
export FZF_DEFAULT_COMMAND="ffind -type f"
export FZF_DEFAULT_OPTS="--cycle --multi --reverse --preview-window border-sharp --tabstop=4 --tiebreak=begin,length,end,index --no-info --color=bg+:-1,fg+:-1,border:8,hl:1,hl+:1,prompt:4,pointer:2,marker:3,info:8"
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWUPSTREAM=auto

case $0 in
    *bash) . "$HOME/.bashrc" ;;
esac

if [ "$TERM" = linux ]; then
    # NORMAL
    printf "\033]P0000000" # black
    printf "\033]P1db2d20" # red
    printf "\033]P201a252" # green
    printf "\033]P3fded02" # yellow
    printf "\033]P45e81ac" # blue
    printf "\033]P5a16a94" # magenta
    printf "\033]P68fbcbb" # cyan
    printf "\033]P7a5a2a2" # white
    # BRIGHT
    printf "\033]P84c566a" # black
    printf "\033]P9db2d20" # red
    printf "\033]PA01a252" # green
    printf "\033]PBfded02" # yellow
    printf "\033]PC5e81ac" # blue
    printf "\033]PDa16a94" # magenta
    printf "\033]PE8fbcbb" # cyan
    printf "\033]PFd8dee9" # white
    clear
fi

# AUTOSTART
if [ ! -f /tmp/logged_in ]; then
    touch /tmp/logged_in
    pulsemixer --unmute
    tmux -L tty new -d
    setsid -f bstatus -l > /dev/null 2>&1
    [ "$(tty)" = /dev/tty1 -a "$(whoami)" != root ] && exec sx
fi

[ "$(tty)" = /dev/tty2 -a "$TERM" = linux ] && exec tmux -L tty new -A
