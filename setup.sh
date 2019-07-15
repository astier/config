#!/usr/bin/env sh

install() {
	TARGET=$1 DESTINATION=$2/$(basename "$TARGET")
	sudo rm -fr "$DESTINATION"
	sudo ln -rs "$TARGET" "$DESTINATION" &&
		echo Installed: "$TARGET"
}

cd dotfiles || exit

install .aliases ~
install .profile ~
install .tmux.conf ~
install bash/.bash_profile ~
install bash/.bashrc ~
install bash/.inputrc ~
install git ~/.config
install nvim ~/.config
install xmodmap/.Xmodmap ~
install xmodmap/xmodmap.desktop ~/.config/autostart
