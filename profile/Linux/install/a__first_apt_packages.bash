#!/usr/bin/env bash

set -eEu -o pipefail

declare -a packages

packages=(
    build-essential
    manpages-dev
    libssl-dev
    zlib1g-dev
    libbz2-dev
    libreadline-dev
    libsqlite3-dev
    wget
    curl
    llvm
    libncurses5-dev
    libncursesw5-dev
    xz-utils
    tk-dev
    python-is-python3
    python3-pip
    jq
    bat
)

# not quoting to ensure each package is its own argument
sudo apt-get update
sudo apt-get install -y ${packages[*]}

function _apt_package_installed() {
    sudo apt list --installed "$1" 2>/dev/null | grep -Ei "$1" >/dev/null
}

# # Install Packages
# for p in "${packages[@]}"; do
#   if ! _apt_package_installed "$p"; then
#     apt-get install -y "$p"
#   else
#     echo "package '$p' already installed!"
#   fi
# done

