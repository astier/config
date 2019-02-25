#!/usr/bin/env bash

install () {
    TARGET=$1 DESTINATION=$2$(basename "$TARGET")
    sudo rm -rf "$DESTINATION"
    sudo ln -rs dotfiles/"$TARGET" "$DESTINATION" &&
    echo Installed: "$TARGET"
}

install bash/.bash_profile          ~/
install bash/.bashrc                ~/
install xorg/.xinitrc               ~/
install feh                         ~/.config/
install git                         ~/.config/
install gtk-3.0/                    ~/.config/
install nvim                        ~/.config/
install pacman/pacman.conf          /etc/
install pacman/hooks/               /etc/pacman.d/
install systemd/logind.conf         /etc/systemd/
