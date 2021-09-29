#!/bin/bash
#
# Installs only the dotfiles to your system.
#
# Added mainly to support Github Codespaces. This file will be picked up and run automatically.
#

set -e

make dotfiles
