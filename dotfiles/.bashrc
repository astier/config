[[ $- != *i* ]] && return

HISTCONTROL=erasedups
PS1='\[\e[32m\][\W]\$\[\e[m\] '

set -o vi
shopt -s cdspell

alias df='df -h'
alias htop='htop -t'
alias grep='grep --color'
alias la='ls -a'
alias ll='ls -l'
alias ls='ls --color --group-directories-first -h'
alias pacman='sudo pacman'

alias ..='cd ..'
alias cfb='$EDITOR ~/.bashrc && . ~/.bashrc'
alias cfv='$EDITOR ~/.config/nvim/init.vim'
alias sa='source activate'
alias sd='source deactivate'
alias m='sudo reflector -p https -l64 -f16 --score 8 --sort rate --save /etc/pacman.d/mirrorlist; cat /etc/pacman.d/mirrorlist'
alias v='nvim'

powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
. /usr/share/powerline/bindings/bash/powerline.sh
neofetch
