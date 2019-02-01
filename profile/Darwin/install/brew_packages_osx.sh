#!/usr/bin/env bash

set -eu -o pipefail

# OSX Specific packages

declare -a packages

packages=(
  "jq"
)

for p in "${packages[@]}"; do
  if ! brew ls --versions "$p" > /dev/null; then
    brew install "$p"
  else
    echo "package '$p' already installed!"
  fi
done
