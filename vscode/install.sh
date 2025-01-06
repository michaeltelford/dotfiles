#!/bin/bash
#
# VSCode
#
# Sets up VSCode with your preferred settings, extensions etc.
#

install_settings () {
    info "Installing your preferred VSCode settings..."

    local overwrite_all=false backup_all=true skip_all=false
    link_file "$DOTFILES_ROOT/vscode/settings.json" "/Users/michaeltelford/Library/Application Support/Code/User/settings.json"
}

info "Starting VSCode install..."

# Install your preferred VSCode settings.
install_settings

# Install your preferred VSCode extensions.
info "Manually search for and install the following VSCode extensions:"
info "  - prettify json"
info "  - rest-client"
info "  - gitlens"
info "  - go"
info "  - ruby lsp"

success "VSCode installation complete"
