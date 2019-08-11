#!/usr/bin/env bash

[[ $- != *i* ]] && return
[[ -z "$TMUX" ]] && (tmux a -t 0 || tmux new -c ~ -s 0)

# PROMPT
. ~/.config/git/git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWUPSTREAM="auto"
NO_COLOR="\[\e[m\]"
RED="\[\e[31m\]"
GREEN="\[\e[32m\]"
num_jobs() { NUM_JOBS=$(jobs | wc -l) && [[ "$NUM_JOBS" -gt 0 ]] && echo " $NUM_JOBS"; }
PS1="${GREEN}[\W\$(__git_ps1 ' (%s)')${RED}\$(num_jobs)${GREEN}] ${NO_COLOR}"

# SETTINGS
HISTCONTROL=ignoreboth:erasedups
set -o vi
[[ $DISPLAY ]] && shopt -s checkwinsize
shopt -s autocd cdspell histappend

# MISC
[ -r /opt/ros/melodic/setup.bash ] && . /opt/ros/melodic/setup.bash
[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion
[ -r ~/.aliases ] && . ~/.aliases
[ -r ~/.fzf.bash ] && . ~/.fzf.bash
export PATH=$PATH:~/projects/ase/gcc-arm-embedded
