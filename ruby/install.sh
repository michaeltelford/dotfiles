#!/bin/bash
#
# Ruby
#
# Install any desired ruby versions (using rbenv) and gems (using bundler).
#

info "Starting ruby install..."

eval "$(rbenv init -)"

# List ruby versions to install, do not add a comma between versions. 
# The last version listed will be set as the global default version. 
array=( "2.2.2" )

for version in "${array[@]}"
do
	if rbenv versions | grep -q $version
	then
	  info "Ruby $version already installed"
	else
	  info "Installing ruby $version..."
	  rbenv install $version
	fi
done

# Set the global ruby version.
VERSION=${array[${#array[@]}-1]}
info "Setting global ruby version to $VERSION..."
rbenv global $VERSION

# Install any desired gems...
info "Running 'bundle install'..."
gem install bundler
bundle install --gemfile "$DOTFILES_ROOT/ruby/Gemfile" --jobs 3 || true

success "Ruby installation complete"
