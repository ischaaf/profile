#!/usr/bin/env bash

declare -a packages

packages=(
  "shellcheck"
  "python3"
  "nvim"
  "openssh"
)

if ! brew tap | grep -q "github/kyleburton"; then
  brew tap --full github/kyleburton https://github.com/kyleburton/homebrew-kyleburton.git
else
  echo "github/kyleburton already tapped"
fi

for p in "${packages[@]}"; do
  if ! brew ls --versions "$p" > /dev/null; then
    brew install "$p"
  else
    echo "package '$p' already installed!"
  fi
done


if ! brew ls --versions "github/kyleburton/bake" > /dev/null; then
  brew install github/kyleburton/bake --without-bash
else
  echo "package 'github/kyleburton/bake' already installed!"
fi
