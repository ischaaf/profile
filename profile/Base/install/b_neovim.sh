#!/usr/bin/env bash

set -eu -o pipefail

NVIM_VERSION="0.11.3"
INST_NODE_VERSION="22.14.0"

NVIM_BINARY_URL="https://github.com/neovim/neovim/releases/download/v$NVIM_VERSION/nvim-linux-x86_64.tar.gz"
NVIM_VERSION_STRING="NVIM v$NVIM_VERSION"

if ! command -v nvim >/dev/null 2>&1 || [[ "$(nvim --version)" != "$NVIM_VERSION_STRING" ]]; then
  echo "INSTALLING NEOVIM: $NVIM_VERSION_STRING"
  curl -LO "$NVIM_BINARY_URL"
  sudo rm -rf /opt/nvim-linux-x86_64
  sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
  rm "$HOME/bin/nvim" || :
  ln -s /opt/nvim-linux-x86_64/bin/nvim "$HOME/bin/nvim"
fi

python -m pip install pynvim

(
  export PATH="$HOME/.nodenv/versions/$INST_NODE_VERSION/bin:$PATH"
  npm install -g neovim
)
