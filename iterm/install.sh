#!/bin/bash
#
# iTerm2
#
# Sets up iterm with your preferred settings etc.
#

info "Starting iterm install..."

# Requires manual install step(s).
info "Do the following manually to install your preferred iTerm2 settings from file:"
info "  - Open the iTerm app"
info "  - Open Settings..."
info "  - Click: General > Settings > Import All Settings and Data"
info "  - Select file: $DOTFILES_ROOT/iterm/settings.itermexport"

success "iterm installation complete"
