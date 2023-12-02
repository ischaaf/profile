#!/usr/bin/env bash

set -eEuo pipefail

if [[ -d "$HOME/.config/nvim/.git" ]]; then
  # already installed
  exit 0
else
    (
      # clean out cached files as these will break nvchad setup
      rm -rf "$HOME/.cache/nvim" "$HOME/.local/share/nvim"

      cd "$HOME/.config/nvim/"
      git init
      git remote add origin git@github.com:NvChad/NvChad.git
      git pull origin v2.0
      git fetch
      git checkout -b v2.0
      git pob
    )
fi
