#!/usr/bin/env sh

install() {
    TARGET=$1 DESTINATION=$2/$(basename "$TARGET")
    sudo rm -fr "$DESTINATION"
    sudo ln -rs "$TARGET" "$DESTINATION" &&
        echo Installed: "$TARGET"
}

[ ! -d ~/.config ] && mkdir ~/.config
cd dotfiles || exit

install .bash_profile ~
install .bashrc ~
install .profile ~
install aliases ~/.config
install bash-completion ~/.local/share
install condarc ~/.config
install git ~/.config
install gtk-3.0 ~/.config
install inputrc ~/.config
install mkinitcpio.conf /etc
install nvim ~/.config
install pacman ~/.config
install pacman/pacman.conf /etc
install pylintrc ~/.config
install sx ~/.config
install tmux.conf ~/.config
install xkb ~/.config

[ ! -d /etc/systemd/system/getty@tty1.service.d ] && sudo mkdir /etc/systemd/system/getty@tty1.service.d
sudo ln -f ~/projects/dotfiles/dotfiles/systemd/getty@tty1.service.d/override.conf /etc/systemd/system/getty@tty1.service.d &&
    echo Installed: getty@tty1.service.d
sudo ln -f ~/projects/dotfiles/dotfiles/systemd/journald.conf /etc/systemd &&
    echo Installed: journald
sudo ln -f ~/projects/dotfiles/dotfiles/systemd/logind.conf /etc/systemd &&
    echo Installed: logind
sudo ln -f ~/projects/dotfiles/dotfiles/systemd/network/* /etc/systemd/network &&
    echo Installed: networkd
sudo ln -f ~/projects/dotfiles/dotfiles/iptables.rules /etc/iptables/iptables.rules
    echo Installed: iptables
