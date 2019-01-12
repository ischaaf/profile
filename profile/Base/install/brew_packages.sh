#!/usr/bin/env bash

declare -a packages

packages=(
  "shellcheck"
  "nvim"
)

for p in "${packages[@]}"; do
  if ! brew ls --versions "$p" > /dev/null; then
    brew install "$p"
  else
    echo "package '$p' already installed!"
  fi
done
