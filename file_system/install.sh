#!/bin/bash
#
# File System
#
# Manipulates the file system e.g. created directories, sets permissions etc.
#

info "Starting file system install..."

# Create any desired directories if they don't yet exist. 
create_dir "${HOME}/Downloads"
create_dir "${HOME}/Development"

success "File system installation complete"
