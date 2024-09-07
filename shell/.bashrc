#!/usr/bin/env bash

# Exit if shell is not interactive
[[ $- != *i* ]] && return

# CONFIG
shopt -s autocd cdspell dotglob histappend

# PROMPT
NO_COLOR="\[\e[m\]"
RED="\[\e[31m\]"
GREEN="\[\e[32m\]"
am_i_root() { [ "$(whoami)" = root ] && echo !; }
njobs() { n=$(jobs | wc -l) && [ "$n" -gt 0 ] && echo " $n"; }
PS1="${RED}\$(am_i_root)${GREEN}[\W\$(__git_ps1 ' %s')${RED}\$(njobs)${GREEN}] ${NO_COLOR}"

# SOURCE
BASH_COMPLETION=/usr/share/bash-completion/bash_completion
[ -f "$BASH_COMPLETION" ] && . "$BASH_COMPLETION"
BASHRC_LOCAL="$XDG_CONFIG_HOME/bashrc_local"
[ -f "$BASHRC_LOCAL" ] && . "$BASHRC_LOCAL"
GIT_COMPLETION=/usr/share/git/completion/git-prompt.sh
[ -f "$GIT_COMPLETION" ] && . "$GIT_COMPLETION"

# HISTORY
aliases() { alias | cut -d' ' -f2 | cut -d= -f1 | awk 'length<3' | tr '\n' :; }
functions() { declare -F | cut -d' ' -f3 | awk 'length<3' | tr '\n' :; }
HISTIGNORE=$(aliases)$(functions)
HISTCONTROL=ignoreboth:erasedups
HISTFILE=$XDG_DATA_HOME/bash_history

clean_history() {
    history -a
    tac "$HISTFILE" | awk '!x[$0]++' | tac > /tmp/bash_history
    mv -f /tmp/bash_history "$HISTFILE"
}
trap clean_history EXIT

case "$(tty)" in
    !/dev/tty*) [ -z "$TMUX" ] && command -v tmux >/dev/null && exec tmux ;;
esac
