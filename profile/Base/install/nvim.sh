#!/usr/bin/env bash

mkdir -p "$HOME/.nvm"

if ! command -v nvim; then
  brew install nvm
fi
