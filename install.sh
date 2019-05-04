#!/usr/bin/env bash

install () {
	TARGET=$1 DESTINATION=$2$(basename "$TARGET")
	sudo rm -fr "$DESTINATION"
	sudo ln -rs dotfiles/"$TARGET" "$DESTINATION" &&
	echo Installed: "$TARGET"
}

install bash/.bash_profile			~/
install bash/.bashrc				~/
install .inputrc					~/
install xorg/.xinitrc				~/
install feh							~/.config/
install git							~/.config/
install gtk-3.0						~/.config/
install mimeapps.list				~/.config/
install nvim						~/.config/
install pacman/pacman.conf			/etc/
install pacman/hooks/				/etc/pacman.d/

sudo rm /etc/systemd/logind.conf
sudo ln ~/Projects/dotfiles/dotfiles/systemd/logind.conf /etc/systemd/logind.conf &&
echo Installed: logind
sudo rm /etc/systemd/network/*
sudo ln ~/Projects/dotfiles/dotfiles/systemd/network/* /etc/systemd/network/ &&
echo Installed: networkd
