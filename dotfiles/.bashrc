#!/usr/bin/env bash

[[ $- != *i* ]] && return

# PROMPT
NO_COLOR="\[\e[m\]"
RED="\[\e[31m\]"
GREEN="\[\e[32m\]"
njobs() { n=$(jobs | wc -l) && [ "$n" -gt 0 ] && echo " $n"; }
PS1="${GREEN}[\W\$(__git_ps1 ' %s')${RED}\$(njobs)${GREEN}] ${NO_COLOR}"

# SOURCE
aliases="$XDG_CONFIG_HOME/aliases"
bash_completion=/usr/share/bash-completion/bash_completion
bashrc_local="$XDG_CONFIG_HOME/bashrc_local"
git_completion=/usr/share/git/completion/git-prompt.sh
[ -r "$aliases" ] && . "$aliases"
[ -r "$bash_completion" ] && . "$bash_completion"
[ -r "$bashrc_local" ] && . "$bashrc_local"
[ -r "$git_completion" ] && . "$git_completion"

# HISTORY
aliases() { alias | cut -d' ' -f2 | cut -d= -f1 | awk 'length<3' | tr '\n' :; }
functions() { declare -F | cut -d' ' -f3 | awk 'length<3' | tr '\n' :; }
HISTIGNORE=$(aliases)$(functions)
HISTCONTROL=ignoreboth:erasedups
HISTFILE="$XDG_DATA_HOME"/bash_history

clean_history() {
    history -a
    tac "$HISTFILE" | awk '!x[$0]++' | tac > /tmp/bash_history
    mv -f /tmp/bash_history "$HISTFILE"
}
trap clean_history EXIT
