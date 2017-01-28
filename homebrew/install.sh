#!/bin/bash
#
# Homebrew
#
# Installs the Mac OS X package manager. 
# Updates its indexes and installs the desired dependancies. 
#

info "Starting homebrew install..."

# Check for Homebrew and install if necessary. 
if test ! $(which brew)
then
  info "Installing homebrew..."

  # Install the correct Homebrew for each OS type
  if test "$(uname)" = "Darwin"
  then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  elif test "$(expr substr $(uname -s) 1 5)" = "Linux"
  then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install)"
    PATH="$HOME/.linuxbrew/bin:$PATH"
  fi
fi

# Update Homebrew.
brew cleanup && brew update

# Install Brewfile containing package dependancies ignoring any failures. 
brew bundle --file="$DOTFILES_ROOT/homebrew/Brewfile" || true

success "Homebrew installation complete"
