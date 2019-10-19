#!/usr/bin/env sh

install() {
    TARGET=$1 DESTINATION=$2/$(basename "$TARGET")
    sudo rm -fr "$DESTINATION"
    sudo ln -rs "$TARGET" "$DESTINATION" &&
        echo Installed: "$TARGET"
}

[ ! -d ~/.config ] && mkdir ~/.config
cd dotfiles || exit

install gui/gtk-3.0 ~/.config
install shell/.bash_profile ~
install shell/.bashrc ~
install shell/.profile ~
install shell/aliases ~/.config
install shell/inputrc ~/.config
install system/mkinitcpio.conf /etc
install system/pacman ~/.config
install system/pacman/pacman.conf /etc
install tui/condarc ~/.config
install tui/git ~/.config
install tui/nvim ~/.config
install tui/pylintrc ~/.config
install tui/tmux.conf ~/.config
install x/sx ~/.config
install x/xkb ~/.config

[ ! -d /etc/systemd/system/getty@tty1.service.d ] && sudo mkdir /etc/systemd/system/getty@tty1.service.d
sudo ln -f ~/projects/dotfiles/dotfiles/system/systemd/getty@tty1.service.d/override.conf /etc/systemd/system/getty@tty1.service.d &&
    echo Installed: getty@tty1.service.d
sudo ln -f ~/projects/dotfiles/dotfiles/system/systemd/journald.conf /etc/systemd &&
    echo Installed: journald
sudo ln -f ~/projects/dotfiles/dotfiles/system/systemd/logind.conf /etc/systemd &&
    echo Installed: logind
sudo ln -f ~/projects/dotfiles/dotfiles/system/systemd/network/* /etc/systemd/network &&
    echo Installed: networkd
sudo ln -f ~/projects/dotfiles/dotfiles/system/iptables.rules /etc/iptables/iptables.rules
    echo Installed: iptables
