#!/usr/bin/env sh

[ ! -d ~/.config ] && mkdir ~/.config
cd dotfiles || exit

link() {
    TARGET=$1 DESTINATION=$2/$(basename "$TARGET")
    sudo rm -fr "$DESTINATION"
    sudo ln -rs "$TARGET" "$DESTINATION" &&
        echo Installed: "$TARGET"
}

link .bash_profile ~
link .bashrc ~
link .profile ~
link aliases ~/.config
link condarc ~/.config
link git ~/.config
link gtk-3.0 ~/.config
link inputrc ~/.config
link iptables.rules /etc/iptables
link mkinitcpio.conf /etc
link nvim ~/.config
link pacman ~/.config
link pacman/pacman.conf /etc
link pylintrc ~/.config
link sx ~/.config
link tmux.conf ~/.config
link tty-cursor.conf /etc/tmpfiles.d
link xkb ~/.config
link zathura ~/.config/

copy() { sudo cp -fr "$1" "$2" && echo Installed: "$1"; }

copy systemd/journald.conf /etc/systemd
copy systemd/logind.conf /etc/systemd
copy systemd/system.conf /etc/systemd
copy systemd/network/* /etc/systemd/network
copy systemd/system/* /etc/systemd/system
