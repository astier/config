# Exit if not interactive
[[ $- != *i* ]] && return

# Parameters
HISTCONTROL=erasedups:ignorespace
# PS1='\[\e[32m\][\u@\h:\[\e[34m\]\W\[\e[32m\]]\$\[\e[m\] '
PS1='\[\e[32m\][\w]\$\[\e[m\] '

# Settings
set -o vi
shopt -s autocd

# Aliases
alias ...='cd /'
alias df='df -h'
alias htop='htop -t'
alias mrl='sudo reflector --info -p https -l256 -f32 --score 8 --sort rate --save /etc/pacman.d/mirrorlist'
alias grep='grep --color'
alias la='ls -a'
alias ll='ls -l'
alias ls='ls --color --group-directories-first -h'
alias pacman='sudo pacman --color auto'
alias src='. ~/.bashrc'
alias upd='pacman -Syu'
