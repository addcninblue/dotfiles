.DEFAULT_GOAL:=help

FULL=i3/ maid/ nvim/ polybar/ zshrc/ Xresources/
UBUNTU=i3/ maid/ nvim/ polybar/ zshrc/ Xresources/
MINIMAL=i3/ maid/ nvim/ polybar/ zshrc/ Xresources/
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
	stow -t ~ $(UBUNTU)

.PHONY: minimal
minimal: stow
	cat i3/.config/i3/minimal > i3/.config/i3/config && cat i3/.config/i3/base >> i3/.config/i3/config
	stow -t ~ $(MINIMAL)

.PHONY: uninstall
uninstall: stow
	stow -Dt ~ $(ALL_PACKAGES)

.PHONY: update
update: pull

.PHONY: pull
pull:
	git pull
