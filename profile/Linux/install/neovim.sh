#!/usr/bin/env bash

set -eu -o pipefail

# Install neovim + vim-plug

NEOVIM_AUTOLOAD_FOLDER="$HOME/.local/share/nvim/site/autoload"
PLUG_VIM="$NEOVIM_AUTOLOAD_FOLDER/plug.vim"

if [ ! -f "$PLUG_VIM" ]; then
  curl -fLo "$PLUG_VIM" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

if ! which nvim; then
  brew install neovim
fi

if ! pip3 freeze | grep neovim; then
  pip3 install neovim
fi
