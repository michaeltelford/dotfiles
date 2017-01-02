#!/bin/bash
#
# Add new functionality by adding a topic folder e.g. Node and in it an 
# install.sh script which handles all aspects of that topic. It will be 
# run automatically below. 
#
# Any topic folder containing a file called *.symlinked will be symlinked 
# automatically to the home folder, see the README.md for more details. 
#

DOTFILES_ROOT=$(pwd -P)

set -e
source install_helpers.sh

info_p "Installing development environment..."

# Symlink any required dotfiles in all topic folders. 
symlink_dotfiles

# Install homebrew packages first so topics have the relavent executables 
# in place e.g. rbenv.
source homebrew/install.sh

# Run any topic install.sh scripts next excluding homebrew (called above). 
find . -maxdepth 2 -name 'install.sh' -not -path 'homebrew/install.sh' | while read installer ; do source $installer ; done

success_p "Development environment installation complete"
exit 0
