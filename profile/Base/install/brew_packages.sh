#!/usr/bin/env bash

declare -a packages
declare -a casks

packages=(
  "shellcheck"
  "python3"
  "nvim"
  "openssh"
  "lastpass-cli"
  "postgresql"
  "flyway"
  "npm"
  "emacs"
)

casks=(
  "java"
)

if ! brew tap | grep -q "github/kyleburton"; then
  brew tap --full github/kyleburton https://github.com/kyleburton/homebrew-kyleburton.git
else
  echo "github/kyleburton already tapped"
fi

# Install Casks
for p in "${casks[@]}"; do
  if ! brew cask list --versions "$p" > /dev/null; then
    brew cask install "$p"
  else
    echo "cask '$p' already installed!"
  fi
done

# Install Packages
for p in "${packages[@]}"; do
  if ! brew ls --versions "$p" > /dev/null; then
    brew install "$p"
  else
    echo "package '$p' already installed!"
  fi
done

# Special install for bake since it has options
# TODO: should find a way to standardize this
if ! brew ls --versions "github/kyleburton/bake" > /dev/null; then
  brew install github/kyleburton/bake --without-bash
else
  echo "package 'github/kyleburton/bake' already installed!"
fi
