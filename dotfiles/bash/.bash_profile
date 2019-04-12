export PATH=$PATH:~/miniconda3/bin:~/.local/bin
export EDITOR=nvim
export VISUAL=nvim
export BROWSER=firefox
export DOTFILES=~/Projects/dotfiles/dotfiles

[[ -f ~/.bashrc ]] && . ~/.bashrc
[[ "$(tty)" = "/dev/tty1" && "$(whoami)" != "root" ]] && startx
