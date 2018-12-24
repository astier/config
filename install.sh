#!/bin/bash

install () {
    TARGET=$1 DIR=$2
    sudo rm -rf $DIR$TARGET
    sudo ln -nrs dotfiles/$TARGET $DIR$TARGET &&
    echo Installed: $TARGET
}

install .bash_profile           ~/
install .bashrc                 ~/
install .xinitrc                ~/
install git                     ~/.config/
install nvim                    ~/.config/
install pacman.conf             /etc/
