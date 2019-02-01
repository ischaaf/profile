#!/usr/bin/env bash

set -eu -o pipefail

declare -a packages

packages=(
  "eslint"
)

for p in "${packages[@]}"; do
  if yarn global list | grep -q "$p"; then
    echo "yarn package $p already installed!"
  else
    yarn global add "$p"
  fi
done
