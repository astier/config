#!/usr/bin/env sh

export PATH="$HOME/.local/bin:$PATH"

export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CONFIG_DIRS="$XDG_CONFIG_HOME:/etc/xdg:$XDG_CONFIG_DIRS"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_DATA_DIRS="$XDG_DATA_HOME:/usr/local/share:/usr/share:$XDG_DATA_DIRS"

export _JAVA_AWT_WM_NONREPARENTING=1
export DISPLAY=:1
export GTK_THEME=Adwaita:dark
export XAUTHORITY="$XDG_DATA_HOME/sx/xauthority"
export XDG_SESSION_TYPE=x11

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
export TERMINAL=st

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
    BLACK=000000
    RED=db2d20
    GREEN=01a252
    YELLOW=fded02
    BLUE=5e81ac
    MAGENTA=a16a94
    CYAN=8fbcbb
    WHITE=a5a2a2
    BRIGHTBLACK=4c566a
    # NORMAL
    printf "\033]P0%s" "$BLACK"
    printf "\033]P1%s" "$RED"
    printf "\033]P2%s" "$GREEN"
    printf "\033]P3%s" "$YELLOW"
    printf "\033]P4%s" "$BLUE"
    printf "\033]P5%s" "$MAGENTA"
    printf "\033]P6%s" "$CYAN"
    printf "\033]P7%s" "$WHITE"
    # BRIGHT
    printf "\033]P8%s" "$BRIGHTBLACK"
    printf "\033]P9%s" "$RED"
    printf "\033]PA%s" "$GREEN"
    printf "\033]PB%s" "$YELLOW"
    printf "\033]PC%s" "$BLUE"
    printf "\033]PD%s" "$MAGENTA"
    printf "\033]PE%s" "$CYAN"
    printf "\033]PF%s" "$BRIGHTBLACK"
    clear
fi

# AUTOSTART
if [ ! -f /tmp/autostarted ]; then
    pulsemixer --unmute
    setsid -f bstatus -l > /dev/null 2>&1
    tmux new -d \; splitw -hb
    touch /tmp/autostarted
fi

if [ "$(tty)" = /dev/tty1 ] && [ ! -f /tmp/logged_in ]; then
    touch /tmp/logged_in
    exec sx
fi

if [ "$(tty)" = /dev/tty2 ] && [ "$TERM" = linux ]; then
    if [ -n "$(pgrep -f tmux)" ]; then
        exec tmux attach
    else
        exec tmux new \; splitw -hb
    fi
fi
