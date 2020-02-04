# Local Variables:
# mode: makefile
# End:
# vim: set ft=make :

CHROMEBOOK := nvim/ zshrc/ tmux/ ranger/ radare2/ kitty/ fonts/

setup: install stow postinstall

install:
	OS=$(awk -F= '/^NAME/{print $2}' /etc/os-release | tr -d '"')
	case $OS in
		"Ubuntu")
			echo "install"
			;;
		"buntu")
			# all packages
			sudo apt-get update
			sudo apt-get install git stow zsh tmux ranger silversearcher-ag
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
	~/.fzf/install

neovim: languageservers
	pip3 install --user neovim

languageservers: pyls

pyls:
	pip3 install 'python-language-server[all]'

kitty:
	curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
