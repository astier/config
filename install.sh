#!/usr/bin/env bash

install () {
    TARGET=$1 DESTINATION=$2$(basename "$TARGET")
    sudo rm -rf "$DESTINATION"
    sudo ln -rs dotfiles/"$TARGET" "$DESTINATION" &&
    echo Installed: "$TARGET"
}

install .bash_profile               ~/
install .bashrc                     ~/
install .pylintrc                   ~/
install .xinitrc                    ~/
install git                         ~/.config/
install htop                        ~/.config/
install nvim                        ~/.config/
install vscode/keybindings.json     ~/.config/Code/User/
install vscode/settings.json        ~/.config/Code/User/
install pacman/pacman.conf          /etc/
install pacman/hooks/               /etc/pacman.d/
