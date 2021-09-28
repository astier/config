#!/usr/bin/env bash

[[ $- != *i* ]] && return

# CONFIG
shopt -s autocd cdspell dotglob histappend
SHRC="$XDG_CONFIG_HOME/shrc"
[ -r "$SHRC" ] && . "$SHRC"

# PROMPT
NO_COLOR="\[\e[m\]"
RED="\[\e[31m\]"
GREEN="\[\e[32m\]"
njobs() { n=$(jobs | wc -l) && [ "$n" -gt 0 ] && echo " $n"; }
PS1="${GREEN}[\W\$(__git_ps1 ' %s')${RED}\$(njobs)${GREEN}] ${NO_COLOR}"

# SOURCE
BASH_COMPLETION=/usr/share/bash-completion/bash_completion
[ -r "$BASH_COMPLETION" ] && . "$BASH_COMPLETION"
BASHRC_LOCAL="$XDG_CONFIG_HOME/bashrc_local"
[ -r "$BASHRC_LOCAL" ] && . "$BASHRC_LOCAL"
FZF_COMPLETION=/usr/share/fzf/completion.bash
[ -r "$FZF_COMPLETION" ] && . "$FZF_COMPLETION"
FZF_KEY_BINDINGS=/usr/share/fzf/key-bindings.bash
[ -r "$FZF_KEY_BINDINGS" ] && . "$FZF_KEY_BINDINGS"
GIT_COMPLETION=/usr/share/git/completion/git-prompt.sh
[ -r "$GIT_COMPLETION" ] && . "$GIT_COMPLETION"

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
