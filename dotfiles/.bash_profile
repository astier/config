export EDITOR=nvim
export PATH="$PATH:~/miniconda3/bin:~/bin"

setxkbmap -option caps:swapescape

# Load .bashrc
[[ -f ~/.bashrc ]] && . ~/.bashrc

# Start X at login
if [[ "$(tty)" = "/dev/tty1" && "$(whoami)" != "root" ]]; then
    startx
fi
