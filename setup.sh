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
install condarc ~/.config
install git ~/.config
install gtk-3.0 ~/.config
install herbstluftwm ~/.config
install inputrc ~/.config
install mkinitcpio.conf /etc
install nvim ~/.config
install pacman ~/.config
install pacman/pacman.conf /etc
install pylintrc ~/.config
install sx ~/.config
install sxhkd ~/.config
install tmux.conf ~/.config
install xkb ~/.config
install zathura ~/.config/

sudo cp -f ./iptables.rules /etc/iptables && echo Installed: iptables
sudo cp -f ./systemd/journald.conf /etc/systemd && echo Installed: journald
sudo cp -f ./systemd/logind.conf /etc/systemd && echo Installed: logind
sudo cp -f ./systemd/network/* /etc/systemd/network && echo Installed: networkd
sudo cp -f ./tty-no-cursor-blink.conf /etc/tmpfiles.d && echo Installed: tty-no-cursor-blink
sudo cp -fr ./systemd/system/* /etc/systemd/system && echo Installed: getty@ttyN.service.d
