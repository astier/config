#!/usr/bin/env bash

install () {
    TARGET=$1 DESTINATION=$2$(basename "$TARGET")
    sudo rm -rf "$DESTINATION"
    sudo ln -rs dotfiles/"$TARGET" "$DESTINATION" &&
    echo Installed: "$TARGET"
}

install .bash_profile               ~/
install .bashrc                     ~/
install .xinitrc                    ~/
install feh                         ~/.config/
install git                         ~/.config/
install nvim                        ~/.config/
install pacman/pacman.conf          /etc/
install pacman/hooks/               /etc/pacman.d/
install st/st.desktop               /usr/share/applications/
