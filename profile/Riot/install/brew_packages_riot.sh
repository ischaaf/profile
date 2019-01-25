#!/usr/bin/env bash

declare -a packages
declare -a casks

packages=(
  "awscli"
  "envconsul"
)

casks=(
)

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
