#!/bin/bash
#
# VSCode
#
# Sets up VSCode with your preferred settings, extensions etc.
# Assumes 'code' aleady exists in $PATH - see homebrew topic.
#

# Install your preferred VSCode settings.
install_settings () {
    info "Installing your preferred VSCode settings..."

    if test "$(uname)" = "Darwin"; then
        local path="$HOME/Library/Application Support/Code/User/settings.json"
    else
        local path="$HOME/.config/Code/User"
    fi

    local overwrite_all=false backup_all=true skip_all=false
    link_file "$DOTFILES_ROOT/vscode/settings.json" $path
}

# Install your preferred VSCode extensions.
install_extensions () {
    if test $(which code); then
        info "Installing VSCode extensions..."

        code --install-extension eamodio.gitlens --force
        code --install-extension mhutchie.git-graph --force
        code --install-extension mohsen1.prettify-json --force
        code --install-extension humao.rest-client --force
        code --install-extension golang.go --force
        code --install-extension shopify.ruby-lsp --force
        code --install-extension github.copilot --force
    fi
}

info "Starting VSCode install..."

install_settings
install_extensions

success "VSCode installation complete"
