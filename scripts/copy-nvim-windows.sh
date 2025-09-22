#!/usr/bin/env bash

set -eEuo pipefail

WSL_NVIM_CONFIG_PATH="$HOME/.config/nvim"
WINDOWS_NVIM_CONFIG_BASE_PATH="/mnt/c/Users/$WINDOWS_LOGNAME/AppData/Local"

cp -rL "$WSL_NVIM_CONFIG_PATH" "$WINDOWS_NVIM_CONFIG_BASE_PATH"
