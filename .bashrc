#!/usr/bin/env bash

[[ $- != *i* ]] && return

shopt -s autocd cdspell dotglob histappend

# PROMPT
NO_COLOR="\[\e[m\]"
RED="\[\e[31m\]"
GREEN="\[\e[32m\]"
njobs() { n=$(jobs | wc -l) && [ "$n" -gt 0 ] && echo " $n"; }
PS1="${GREEN}[\W\$(__git_ps1 ' %s')${RED}\$(njobs)${GREEN}] ${NO_COLOR}"

# SOURCE
bash_completion=/usr/share/bash-completion/bash_completion
bashrc_local="$XDG_CONFIG_HOME/bashrc_local"
fzf_completion=/usr/share/fzf/completion.bash
fzf_key_bindings=/usr/share/fzf/key-bindings.bash
git_completion=/usr/share/git/completion/git-prompt.sh
shrc="$XDG_CONFIG_HOME/shrc"
[ -r "$bash_completion" ] && . "$bash_completion"
[ -r "$bashrc_local" ] && . "$bashrc_local"
[ -r "$fzf_completion" ] && . "$fzf_completion"
[ -r "$fzf_key_bindings" ] && . "$fzf_key_bindings"
[ -r "$git_completion" ] && . "$git_completion"
[ -r "$shrc" ] && . "$shrc"

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
