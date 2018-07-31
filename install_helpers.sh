#!/bin/bash
#
# Helper methods for the install scripts.
#
# Much of the functionality in this file has been taken from:
# https://github.com/holman/dotfiles/blob/master/script/bootstrap
#

set -e

export DOTFILES_ROOT=$(pwd -P)

info () {
  printf "\r  [ \033[00;34m..\033[0m ] $1\n"
}

user () {
  printf "\r  [ \033[0;33m??\033[0m ] $1\n"
}

success () {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

fail () {
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
  echo ''
  exit 1
}

setup_gitconfig () {
  if ! [ -f git/gitconfig.local.symlink ]
  then
    info 'Initialising git configuration...'

    git_credential='cache'
    if [ "$(uname -s)" == "Darwin" ]
    then
      git_credential='osxkeychain'
    fi

    user ' - What is your full name (not your GitHub handle)?'
    read -e git_authorname
    user ' - What is your github author email?'
    read -e git_authoremail

    sed -e "s/AUTHORNAME/$git_authorname/g" -e "s/AUTHOREMAIL/$git_authoremail/g" -e "s/GIT_CREDENTIAL_HELPER/$git_credential/g" git/gitconfig.local.symlink.example > git/gitconfig.local.symlink

    success 'Git configuration complete'
  fi
}

link_file () {
  local src=$1 dst=$2

  local overwrite= backup= skip=
  local action=

  if [ -f "$dst" -o -d "$dst" -o -L "$dst" ]
  then

    if [ "$overwrite_all" == "false" ] && [ "$backup_all" == "false" ] && [ "$skip_all" == "false" ]
    then

      local currentSrc="$(readlink $dst)"

      if [ "$currentSrc" == "$src" ]
      then

        skip=true;

      else

        user "File already exists: $dst ($(basename "$src")), what do you want to do?\n\
        [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all?"
        read -n 1 action

        case "$action" in
          o )
            overwrite=true;;
          O )
            overwrite_all=true;;
          b )
            backup=true;;
          B )
            backup_all=true;;
          s )
            skip=true;;
          S )
            skip_all=true;;
          * )
            ;;
        esac

      fi

    fi

    overwrite=${overwrite:-$overwrite_all}
    backup=${backup:-$backup_all}
    skip=${skip:-$skip_all}

    if [ "$overwrite" == "true" ]
    then
      rm -rf "$dst"
      success "Removed $dst"
    fi

    if [ "$backup" == "true" ]
    then
      # Only backup if the $dst file isn't a symlink.
      if [ -L "$dst" ]
      then
        rm -f "$dst"
      else
        mv "$dst" "${dst}.backup"
        success "Moved $dst to ${dst}.backup"
      fi
    fi

    if [ "$skip" == "true" ]
    then
      success "Skipped $src"
    fi
  fi

  if [ "$skip" != "true" ]  # "false" or empty
  then
    ln -s "$1" "$2"
    success "Sym linked $1 to $2"
  fi
}

symlink_dotfiles () {
  info "Symlinking dotfiles..."

  local overwrite_all=false backup_all=true skip_all=false

  for src in $(find -H "$DOTFILES_ROOT" -maxdepth 2 -name '*.symlink' -not -path '*.git*')
  do
    dst="$HOME/.$(basename "${src%.*}")"
    link_file "$src" "$dst"
  done

  success "Symlinking dotfiles complete"
}

create_dir () {
  if [ ! -d "${1}" ]; then
    info "Creating directory: ${1}"
    mkdir -p "${1}"
  fi
}

create_file () {
  if [ ! -f "${1}" ]; then
    info "Creating file: ${1}"
    touch "${1}"
    if [ $# -eq 2 ]; then
      echo "${2}" >> "${1}"
    fi
  fi
}

installed () {
  !(test ! $(which $1))
}
