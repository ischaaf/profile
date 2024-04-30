#!/usr/bin/env bash

set -eu -o pipefail

pip_packages="$(pip freeze)"
packages=(
    black
    isort
    ipython
    arrow
    mypy
    docopt-sh
)

for package in "${packages[@]}"; do
    if ! echo "$pip_packages" | grep -q "$package"; then
        pip install "$package"
    fi
done

