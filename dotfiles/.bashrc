[[ $- != *i* ]] && return

# Parameters
HISTCONTROL=erasedups
PS1='\[\e[32m\][\W]\$\[\e[m\] '

# Settings
set -o vi
shopt -s cdspell

# Defaults
alias df='df -h'
alias htop='htop -t'
alias grep='grep --color'
alias la='ls -a'
alias ll='ls -l'
alias ls='ls --color --group-directories-first -h'
alias pacman='sudo pacman'

# Shortcuts
alias ..='cd ..'
alias sa='source activate'
alias sd='source deactivate'
alias m='sudo reflector -p https -l64 -f16 --score 8 --sort rate --save /etc/pacman.d/mirrorlist; cat /etc/pacman.d/mirrorlist'
alias v='nvim'

# Dotfiles
alias cfb='$EDITOR ~/.bashrc && . ~/.bashrc'
alias cfv='$EDITOR ~/.config/nvim/init.vim'
alias cft='$EDITOR ~/.config/termite/config'

. /usr/share/powerline/bindings/bash/powerline.sh
