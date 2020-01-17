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
aliases=~/.config/aliases
[ -r $aliases ] && . $aliases
completion=/usr/share/bash-completion/bash_completion
[ -r $completion ] && . $completion
