# Local Variables:
# mode: makefile
# End:
# vim: set ft=make :

CHROMEBOOK := "nvim/ zshrc/ tmux/ ranger/ radare2/ kitty/ fonts/"

setup: install stow postinstall

install:
	#!/bin/bash
	OS=$(awk -F= '/^NAME/{print $2}' /etc/os-release | tr -d '"')
	case $OS in
		"Ubuntu")
			# all packages
			sudo apt-get update
			sudo apt-get install -y git stow zsh tmux ranger silversearcher-ag
			# neovim
			sudo apt-get install -y software-properties-common
			sudo add-apt-repository -y ppa:neovim-ppa/stable
			sudo apt-get update
			sudo apt-get install -y neovim
			sudo apt-get install -y python-dev python-pip python3-dev python3-pip
			;;
	esac

stow:
	stow -t ~ {{CHROMEBOOK}}

postinstall: fzf neovim kitty

fzf:
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
	~/.fzf/install --all

neovim: languageservers
	pip3 install --user neovim

languageservers: pyls

pyls:
	pip3 install 'python-language-server[all]'

kitty:
	curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin \
	    launch=n
	mkdir -p ~/.local/bin
	mkdir -p ~/.local/share/applications
	# Create a symbolic link to add kitty to PATH (assuming ~/.local/bin is in
	# your PATH)
	ln -s ~/.local/kitty.app/bin/kitty ~/.local/bin/
	# Place the kitty.desktop file somewhere it can be found by the OS
	cp ~/.local/kitty.app/share/applications/kitty.desktop ~/.local/share/applications
	# Update the path to the kitty icon in the kitty.desktop file
	sed -i "s/Icon\=kitty/Icon\=\/home\/$USER\/.local\/kitty.app\/share\/icons\/hicolor\/256x256\/apps\/kitty.png/g" ~/.local/share/applications/kitty.desktop
