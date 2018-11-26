
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Parameters
EDITOR=nano
HISTCONTROL=ignoreboth
HISTSIZE=100
HISTFILESIZE=200
PATH="$PATH/home/aleks/miniconda3/bin"
PS1='\[\e[32m\][\u@\h:\W]\$ \[\e[m\]'

# Settings
set -o vi
shopt -s autocd
shopt -s checkwinsize
shopt -s histappend

# Aliases
alias grep='grep --color=auto'
alias ls='ls --color=auto'

