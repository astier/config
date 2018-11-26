export EDITOR=nano
export PATH="$PATH:/home/aleks/miniconda3/bin"

# Load .bashrc
[[ -f ~/.bashrc ]] && . ~/.bashrc

# Start X at login
if [[ "$(tty)" = "/dev/tty1" && "$(whoami)" != "root" ]]; then
    startx
fi
