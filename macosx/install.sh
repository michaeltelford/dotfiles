#!/bin/bash
#
# Mac OS X
#
# Install any Mac related behaviour below e.g. system defaults etc. 
#

if test "$(uname)" = "Darwin"; then
	info "Starting Mac OS X install..."

	defaults write com.apple.finder AppleShowAllFiles TRUE

	# Use AirDrop over every interface. Seriously, this should be a default.
	defaults write com.apple.NetworkBrowser BrowseAllInterfaces 1

	# Always open everything in Finder's list view. This is important.
	defaults write com.apple.Finder FXPreferredViewStyle Nlsv

	# Show the ~/Library folder.
	chflags nohidden ~/Library

	# Set the Finder prefs for showing a few different volumes on the Desktop.
	defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
	defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

	# Run the screensaver if we're in the bottom-right hot corner.
	defaults write com.apple.dock wvous-br-corner -int 5
	defaults write com.apple.dock wvous-br-modifier -int 0

	# Set up Safari for development.
	defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
	defaults write com.apple.Safari IncludeDevelopMenu -bool true
	defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
	defaults write com.apple.Safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -bool true
	defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

	success "Mac OS X installation complete"
fi
