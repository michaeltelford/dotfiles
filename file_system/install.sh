#!/bin/bash
#
# File System
#
# Manipulates the file system e.g. created directories, sets permissions etc.
#

info "Starting file system install..."

# Create any desired directories if they don't yet exist.
create_dir "${HOME}/.v" # Docker volumes dir
create_dir "${HOME}/Downloads"
create_dir "${HOME}/Development"
create_dir "${HOME}/Development/Spike"
create_dir "${HOME}/Development/Ruby"
create_dir "${HOME}/Development/Python"
create_dir "${HOME}/Development/Java"
create_dir "${HOME}/Development/PHP"
create_dir "${HOME}/Development/Go"

success "File system installation complete"
