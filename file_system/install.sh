#!/bin/bash
#
# File System
#
# Manipulates the file system e.g. creates directories, sets permissions etc.
#

info "Starting file system install..."

# Create any desired directories if they don't yet exist.
create_dir "${HOME}/.v" # Docker volumes dir
create_dir "${HOME}/Downloads"
create_dir "${HOME}/Development"
create_dir "${HOME}/Development/Spikes"
create_dir "${HOME}/Development/Ruby"
create_dir "${HOME}/Development/Crystal"
create_dir "${HOME}/Development/Go"
create_dir "${HOME}/Development/V"
create_dir "${HOME}/Development/Javascript"

# Create any desired files if they don't yet exist.
create_file "${DOTFILES_ROOT}/bash/bash_temp_functions.symlink" "#!/bin/bash"
create_file "${DOTFILES_ROOT}/bash/bash_temp_exports.symlink" "#!/bin/bash"
create_file "${DOTFILES_ROOT}/bash/bash_temp_aliases.symlink" "#!/bin/bash"

success "File system installation complete"
