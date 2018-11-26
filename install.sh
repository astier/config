#!/bin/bash

install () {
    TARGET=$1 DIR=$2
    sudo rm -rf $DIR$TARGET
    sudo ln -nrs dotfiles/$TARGET $DIR$TARGET &&
    echo Installed: $TARGET
}

install .bash_profile           ~/
install .bashrc                 ~/
install .profile                ~/
install .vimrc                  ~/
install git                     ~/.config/
install xfce4                   ~/.config/
install nanorc                  /etc/
install hooks                   /etc/pacman.d/
install logind.conf             /etc/systemd/
install getty@tty1.service.d    /etc/systemd/system/
# sudo systemctl daemon-reload
install xinitrc                 /etc/X11/xinit/
install 00-keyboard.conf        /etc/X11/xorg.conf.d/

