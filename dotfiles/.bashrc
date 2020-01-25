#!/usr/bin/env bash

[[ $- != *i* ]] && return

# PROMPT
. ~/.config/git/git-prompt.sh
NO_COLOR="\[\e[m\]"
RED="\[\e[31m\]"
GREEN="\[\e[32m\]"
njobs() { n=$(jobs | wc -l) && [ "$n" -gt 0 ] && echo " $n"; }
PS1="${GREEN}[\W\$(__git_ps1 ' %s')${RED}\$(njobs)${GREEN}] ${NO_COLOR}"

# SETTINGS
set -o vi
shopt -s autocd
shopt -s cdspell
shopt -s checkwinsize
shopt -s cmdhist
shopt -s histappend

# SOURCE
aliases=~/.config/aliases
[ -r $aliases ] && . $aliases
completion=/usr/share/bash-completion/bash_completion
[ -r $completion ] && . $completion

# HISTIGNORE
aliases() { alias | cut -d' ' -f2 | cut -d= -f1 | awk 'length<3' | tr '\n' :; }
functions() { declare -F | cut -d' ' -f3 | awk 'length<3' | tr '\n' :; }
HISTIGNORE=$(aliases)$(functions)
HISTCONTROL=ignoreboth:erasedups
HISTFILE=~/.local/share/bash_history
