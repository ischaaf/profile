#!/usr/bin/env bash

set -eu -o pipefail

if ! command -v nvim >/dev/null 2>&1; then
    sudo add-apt-repository ppa:neovim-ppa/unstable
    sudo apt-get install -y neovim
fi

NEOVIM_AUTOLOAD_FOLDER="$HOME/.local/share/nvim/site/autoload"
PLUG_VIM="$NEOVIM_AUTOLOAD_FOLDER/plug.vim"

if [ ! -f "$PLUG_VIM" ]; then
  curl -fLo "$PLUG_VIM" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

python -m pip install pynvim

(
    export PATH="$HOME/.nodenv/versions/16.13.0/bin:$PATH"
    npm install -g neovim
)
