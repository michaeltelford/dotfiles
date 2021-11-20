#!/bin/bash
#
# Ruby
#
# Install any desired Ruby versions (using rbenv) and gems (using bundler).
#

info "Starting ruby install..."

eval "$(rbenv init -)"

# List Ruby versions to install, do NOT add a comma between versions.
# The LAST version listed will be set as the global default version.
versions=( "3.0.2" "2.7.4" )

for version in "${versions[@]}"
do
	if rbenv versions | grep -q $version
	then
	  info "Ruby $version already installed"
	else
	  info "Installing ruby $version..."
	  rbenv install $version
	fi
done

# Set the global Ruby version.
VERSION=${versions[${#versions[@]}-1]}
info "Setting global ruby version to $VERSION..."
rbenv global $VERSION

# Install any desired gems (for the global version of Ruby)...
info "Running 'bundle install'..."

gem update --system
gem install bundler

bundle install --gemfile "$DOTFILES_ROOT/ruby/Gemfile" --jobs 3 || true

success "Ruby installation complete"
