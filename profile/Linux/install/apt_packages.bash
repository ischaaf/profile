#!/usr/bin/env bash

set -eEu -o pipefail

declare -a packages

packages=(
)

# not quoting to ensure each package is its own argument
apt-get install -y ${packages[*]}

function _apt_package_installed() {
    apt list --installed "$1" 2>/dev/null | grep -Ei "$1" >/dev/null
}

# # Install Packages
# for p in "${packages[@]}"; do
#   if ! _apt_package_installed "$p"; then
#     apt-get install -y "$p"
#   else
#     echo "package '$p' already installed!"
#   fi
# done

