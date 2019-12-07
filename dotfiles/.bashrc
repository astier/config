#!/usr/bin/env bash

[[ $- != *i* ]] && return

# PROMPT
. ~/.config/git/git-prompt.sh
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWUPSTREAM="auto"
NO_COLOR="\[\e[m\]"
RED="\[\e[31m\]"
GREEN="\[\e[32m\]"
num_jobs() { NUM_JOBS=$(jobs | wc -l) && [[ "$NUM_JOBS" -gt 0 ]] && echo " $NUM_JOBS"; }
PS1="${GREEN}[\W\$(__git_ps1 ' %s')${RED}\$(num_jobs)${GREEN}] ${NO_COLOR}"

# SETTINGS
HISTFILE=~/.local/share/bash_history
HISTCONTROL=ignoreboth:erasedups
HISTIGNORE=df:x:xd:xm:xp:cel:cod:cou:a:fb:fv:fx:db:fu:myo:n:nn:vml
HISTIGNORE+=:k:kgg:krb:krh:ka:kaa:kam:kb:kbd:kbr:kr:kc:kca:kcp:kcr
HISTIGNORE+=:kd:kk:kl:klg:ks:kso:ko:kob:kma:kf:km:kp:kpf:kpl
HISTIGNORE+=:krm:krr:krs:krv:ksd:ksl:ksp:kst
HISTIGNORE+=:z:ca:co:fl:ms:o:tm:vi:h
HISTIGNORE+=:am:cl:e:i:ii:ir:j:lb:ll:ma:mai:pw:r:re:u:up
HISTIGNORE+=:aa:ab:aaa:ad:cn:dm:dw:fd:fj:ft:sc:si:sl
HISTIGNORE+=:t:ta:tk:tl:c:d:f:l
HISTIGNORE+=:bst:cpm:efs:sys:wal:st
[[ $DISPLAY ]] && shopt -s checkwinsize
set -o vi
shopt -s autocd cdspell cmdhist histappend

# SOURCE
[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion
[ -r ~/.config/aliases ] && . ~/.config/aliases
[ -r ~/miniconda3/etc/profile.d/bash_completion.sh ] &&. ~/miniconda3/etc/profile.d/bash_completion.sh

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

# pip bash completion start
_pip_completion() {
    COMPREPLY=( $( COMP_WORDS="${COMP_WORDS[*]}" \
                   COMP_CWORD=$COMP_CWORD \
                   PIP_AUTO_COMPLETE=1 $1 ) )
}
complete -o default -F _pip_completion pip
# pip bash completion end
