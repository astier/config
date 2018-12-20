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
install nano                    ~/.config/
install nvim                    ~/.config/
install pacman.conf             /etc/
install hooks                   /etc/pacman.d/
install journald.conf           /etc/systemd/
install logind.conf             /etc/systemd/
install getty@tty1.service.d    /etc/systemd/system/
