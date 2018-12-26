[[ $- != *i* ]] && return

HISTCONTROL=erasedups
PS1='\[\e[32m\][\W]\$\[\e[m\] '

set -o vi
shopt -s autocd
shopt -s cdspell

alias cfb='$EDITOR ~/.bashrc && src'
alias cfv='$EDITOR ~/.config/nvim/init.vim'
alias df='df -h'
alias htop='htop -t'
alias mrl='sudo reflector -p https -l64 -f16 --score 8 --sort rate --save /etc/pacman.d/mirrorlist; cat /etc/pacman.d/mirrorlist'
alias grep='grep --color'
alias la='ls -a'
alias ll='ls -l'
alias ls='ls --color --group-directories-first -h'
alias pacman='sudo pacman'
alias src='. ~/.bashrc'
