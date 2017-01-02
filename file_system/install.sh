#!/bin/bash
#
# File System
#
# Manipulates the file system e.g. created directories, sets permissions etc.
#

info_p "Starting file system install..."

# Create any desired directories if they don't yet exist. 
create_dir "${HOME}/Development"
create_dir "${HOME}/Downloads"

success_p "File system installation complete"
