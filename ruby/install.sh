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
array=( "2.2.2" "2.4.0" )

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

# Set the global Ruby version.
VERSION=${array[${#array[@]}-1]}
info "Setting global ruby version to $VERSION..."
rbenv global $VERSION

# Install any desired gems (for the global version of Ruby)...
info "Running 'bundle install'..."

gem update --system
gem install bundler

bundle config build.nokogiri --use-system-libraries
bundle install --gemfile "$DOTFILES_ROOT/ruby/Gemfile" --jobs 2 || true

success "Ruby installation complete"
