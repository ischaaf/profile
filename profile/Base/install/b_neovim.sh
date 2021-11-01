#!/usr/bin/env bash

set -eu -o pipefail

if ! command -v nvim >/dev/null 2>&1; then
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
    chmod u+x nvim.appimage
    ./nvim.appimage
fi
