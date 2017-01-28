#!/bin/bash
#
# Running `make install` will run all the below tasks installing everything. 
# Alternatively you can choose what parts to install yourself. 
# 
# Add new functionality by adding a topic folder e.g. ./node and in it an 
# install.sh script which handles all aspects of that topic. It will be 
# run automatically by `make topics` below. 
#
# Any topic folder containing a file called *.symlinked will be symlinked 
# automatically to the home folder by `make symlink`, see the README.md 
# for more details. 
#

SHELL := /bin/bash
DOTFILES_ROOT := `pwd -P`
DOTFILES_BACKUP := ~/Downloads/dotfiles_backup

.PHONY: help backup install symlink dotfiles brew homebrew topics run

help:
	@echo ""
	@echo "Dotfiles"
	@echo ""
	@echo "install  - Installs dotfiles, homebrew and topics."
	@echo "dotfiles - Installs dotfile symlinks."
	@echo "brew     - Installs homebrew packages."
	@echo "topics   - Runs all topic installers."
	@echo "run      - Runs the given topic installer."
	@echo "           Use 'make run TOPIC=ruby' etc."
	@echo "           Note: some installers require certain brew packages."
	@echo ""

# Not called during install because dotfiles are backed up automatically, 
# used purely for development of this dotfile project.
backup:
	@source "$(DOTFILES_ROOT)/install_helpers.sh" && \
	setup_backup_dir
	@find ~ -maxdepth 1 -type f -name '.*' -exec mv {} $(DOTFILES_BACKUP) \;

install: symlink brew topics
	@# Wrapper for dependant tasks. 

symlink:
	@source "$(DOTFILES_ROOT)/install_helpers.sh" && \
	setup_gitconfig && \
	symlink_dotfiles
dotfiles: symlink
	@# Alias for symlink

brew:
	@source "$(DOTFILES_ROOT)/install_helpers.sh" && \
	source "$(DOTFILES_ROOT)/homebrew/install.sh"
homebrew: brew
	@# Alias for brew. 

topics:
	@source "$(DOTFILES_ROOT)/install_helpers.sh" && \
	find $(DOTFILES_ROOT) -maxdepth 2 -type f -name 'install.sh' \
		-not -path 'homebrew/install.sh' -exec source {} \;

run:
	@source "$(DOTFILES_ROOT)/install_helpers.sh" && \
	source "$(DOTFILES_ROOT)/$(TOPIC)/install.sh"
