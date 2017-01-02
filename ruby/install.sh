#!/bin/bash
#
# Ruby
#
# Install any desired ruby versions (using rbenv) and gems (using bundler).
#

info_p "Starting ruby install..."

# Do not add a comma between versions. 
array=( "2.2.2" )

for version in "${array[@]}"
do
	if rbenv versions | grep -q $version
	then
	  fail "Ruby $version already installed"
	else
	  info "Installing ruby $version..."
	  rbenv install $version
	fi
done

# install any desired gems...
bundle install --gemfile "$DOTFILES_ROOT/ruby/Gemfile" --jobs 3

success_p "Ruby installation complete"
