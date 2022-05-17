#!/bin/bash
#
# Mac OS X
#
# Install any Mac related behaviour below e.g. system defaults etc. 
#

if test "$(uname)" = "Darwin"; then
	info "Starting Mac OS X install..."

    # Display system/hidden files in finder by default. 
	defaults write com.apple.finder AppleShowAllFiles true

	# Always open everything in Finder's list view. 
	defaults write com.apple.Finder FXPreferredViewStyle Nlsv

	success "Mac OS X installation complete"
fi
