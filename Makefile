.DEFAULT_GOAL:=help

FULL=i3/ maid/ nvim/ polybar/ zshrc/ Xresources/
UBUNTU=i3/ maid/ nvim/ polybar/ zshrc/ Xresources/
MINIMAL=i3/ maid/ nvim/ polybar/ zshrc/ Xresources/
ALL_PACKAGES=$(sort $(dir $(wildcard */))) # unused

.PHONY: stow
stow:
	@which stow > /dev/null 2&>1 || { echo "Please install GNU stow"; false; }

.PHONY: help
help:
	@echo "usage: make full    # arch full version"
	@echo "usage: make ubuntu  # ubuntu (server)"
	@echo "usage: make minimal # arch minimal"

.PHONY: full
full: stow
	stow -t ~ $(FULL)

.PHONY: ubuntu
ubuntu: stow
	stow -t ~ $(UBUNTU)

.PHONY: minimal
minimal: stow
	stow -t ~ $(MINIMAL)

.PHONY: uninstall
uninstall: stow
	stow -Dt ~ $(ALL_PACKAGES)

.PHONY: update
update: pull

.PHONY: pull
pull:
	git pull
