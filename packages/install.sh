#!/bin/bash

# Install software packages...

# brew package manager
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "› brew update"
brew update

# install Brewfile containing package dependancies
echo "› brew bundle"
brew bundle
