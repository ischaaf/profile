#!/usr/bin/env bash

set -eu -o pipefail

if ! command -v nvim >/dev/null 2>&1; then
    sudo add-apt-repository ppa:neovim-ppa/unstable
    sudo apt-get install -y neovim
fi
