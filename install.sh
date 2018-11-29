#!/bin/bash

install () {
    TARGET=$1 DIR=$2
    sudo rm -rf $DIR$TARGET
    sudo ln -nrs dotfiles/$TARGET $DIR$TARGET &&
    echo Installed: $TARGET
}

install .bash_profile           ~/
install .bashrc                 ~/
install .cinnamon               ~/
#install .vimrc                  ~/
install .xinitrc                ~/
install git                     ~/.config/
install nano                    ~/.config/
install hooks                   /etc/pacman.d/
install logind.conf             /etc/systemd/
install getty@tty1.service.d    /etc/systemd/system/
install 00-keyboard.conf        /etc/X11/xorg.conf.d/
