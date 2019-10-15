#!/usr/bin/env bash

[[ $- != *i* ]] && return

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
HISTFILE=~/.config/bash_history
HISTIGNORE=a:b:d:e:f:g:i:k:l:n:r:s:t:u:,:..
HISTIGNORE+=:as:ac:af:ah:ao:au:aw:aa:ab:ad:al:ap::av:ax
HISTIGNORE+=:da:lb:ll:pm:pw:py:re:ta:tk:tl:tn:xc:xm:xp:xx:ii:sd:sl:sp:sr:gd:gf
[[ $DISPLAY ]] && shopt -s checkwinsize
set -o vi
shopt -s autocd cdspell histappend

# SOURCE
[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion
[ -r ~/.config/aliases ] && . ~/.config/aliases

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/aleks/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/aleks/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/aleks/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/aleks/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
