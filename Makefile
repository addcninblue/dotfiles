.DEFAULT_GOAL:=help

FULL=i3/ maid/ nvim/ polybar/ zshrc/ Xresources/ tmux/ ranger/ radare2/ compton/ kitty/ fonts/
UBUNTU=nvim/ zshrc/ Xresources/ tmux/ ranger/ kitty/ fonts/
MINIMAL=i3/ maid/ nvim/ polybar/ zshrc/ Xresources/ tmux/ ranger/ compton/ kitty/ fonts/
CHROMEBOOK=nvim/ zshrc/ tmux/ ranger/ radare2/ kitty/ fonts/
ALL_PACKAGES=$(sort $(dir $(wildcard */))) # unused
STOW := $(shell command -v stow 2> /dev/null) # check if stow is installed

.PHONY: stow
stow:
ifndef STOW
    $(error "Please install GNU stow")
endif

.PHONY: help
help:
	@echo "usage: make full    # arch full version"
	@echo "usage: make ubuntu  # ubuntu (server)"
	@echo "usage: make minimal # arch minimal"

.PHONY: full
full: stow
	cat i3/.config/i3/full > i3/.config/i3/config && cat i3/.config/i3/base >> i3/.config/i3/config
	stow -t ~ $(FULL)

.PHONY: ubuntu
ubuntu: stow
	sudo add-apt-repository -y ppa:neovim-ppa/stable
	sudo apt-get update
	sudo apt-get -y install make stow zsh openjdk-8-jre-headless neovim python-dev python-pip python3-dev python3-setuptools
	stow -t ~ $(UBUNTU)

.PHONY: minimal
minimal: stow
	cat i3/.config/i3/minimal > i3/.config/i3/config && cat i3/.config/i3/base >> i3/.config/i3/config
	stow -t ~ $(MINIMAL)

.PHONY: setuparch
setuparch:
	@echo "installing packages"
	./arch/trizen
	trizen -S - < ./arch/packagelist
	@echo "enabling auto login on tty1"
	sudo ./arch/autologin
	@echo "done"

.PHONY: setupchromebook
setupchromebook:
	@echo "setting up chromebook"
	stow -t ~ $(CHROMEBOOK)

.PHONY: uninstall
uninstall: stow
	stow -Dt ~ $(ALL_PACKAGES)

.PHONY: update
update:
	git pull
