#!/bin/bash
#
# Claude Code
#
# Installs Claude Code.
#

info "Starting Claude Code installation..."

# Run the Claude Code installer
curl -fsSL https://claude.ai/install.sh | bash

success "Claude Code installation complete"
