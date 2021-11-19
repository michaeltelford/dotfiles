#!/bin/bash
#
# Running `make install` will run all the below tasks installing everything.
# Alternatively you can choose what parts to install yourself.
#
# Add new functionality by adding a topic folder e.g. ./nodejs and in it an
# install.sh script which handles all aspects of that topic. It will be
# run automatically by `make topics` below.
#
# Any topic folder containing a file called *.symlink will be symlinked
# automatically to the home folder by `make symlink`, see the README.md
# for more details.
#

SHELL := /bin/bash
DOTFILES_ROOT := `pwd -P`

.PHONY: help file_system install symlink dotfiles brew homebrew topics run

help:
	@echo ""
	@echo "Dotfiles"
	@echo "--------"
	@echo ""
	@echo "install     - Installs file_system, dotfiles, homebrew and topics."
	@echo "file_system - Creates all necessary files and directories."
	@echo "dotfiles    - Installs dotfile symlinks."
	@echo "brew        - Installs homebrew packages."
	@echo "topics      - Runs all topic installers."
	@echo "run         - Runs the given topic installer."
	@echo "              Use 'make run TOPIC=ruby' etc."
	@echo "              Note: some installers require certain brew packages."
	@echo ""

install: file_system symlink brew topics
    # Wrapper for dependant tasks.

file_system:
	@source "$(DOTFILES_ROOT)/install_helpers.sh" && \
	source "$(DOTFILES_ROOT)/file_system/install.sh"

symlink:
	@source "$(DOTFILES_ROOT)/install_helpers.sh" && \
	setup_gitconfig && \
	symlink_dotfiles
dotfiles: symlink
    # Alias for symlink.

brew:
	@source "$(DOTFILES_ROOT)/install_helpers.sh" && \
	source "$(DOTFILES_ROOT)/homebrew/install.sh"
homebrew: brew
    # Alias for brew.

topics:
	@source "$(DOTFILES_ROOT)/install_helpers.sh" && \
	find $(DOTFILES_ROOT) -maxdepth 2 -type f -name 'install.sh' \
		-not -path $(DOTFILES_ROOT)/homebrew/install.sh -exec echo {} \;

run:
	@source "$(DOTFILES_ROOT)/install_helpers.sh" && \
	source "$(DOTFILES_ROOT)/$(TOPIC)/install.sh"
