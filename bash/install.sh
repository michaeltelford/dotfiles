#!/bin/bash
#
# Bash
#
# Install any desired bash functionality here.
# Remember that any *.symlink file is automatically symlinked by the 
# bootstrap.sh file and therefore won't need re-done here. 
#

info_p "Starting bash install..."

# Set the default shell to be bash, may require root priveleges. 
info "Setting default shell to bash..."
chsh -s /bin/bash || true

success_p "Bash installation complete"
