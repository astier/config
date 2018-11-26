# Exit if not interactive
[[ $- != *i* ]] && return

# Parameters
HISTCONTROL=erasedups:ignorespace
PS1='\[\e[32m\][\u@\h:\[\e[34m\]\w\[\e[32m\]]\$ \[\e[m\]'

# Settings
set -o vi
shopt -s autocd

# Aliases
alias ...='cd /'
alias mrl='sudo reflector -c Germany -p https -l10 --sort rate --save /etc/pacman.d/mirrorlist; cat /etc/pacman.d/mirrorlist'
alias grep='grep --color'
alias la='ls -a'
alias ll='ls -l'
alias ls='ls --color --group-directories-first -h'
alias pacman='sudo pacman --color auto'
alias src='. ~/.bashrc'
