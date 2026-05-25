#!/usr/bin/env bash

set -eu -o pipefail

# System python version defined in $PROFILE_BASE/.config/uv/.python-version
R_UV_VERSION=0.11.14
if ! command -v uv 2>/dev/null; then
    curl -LsSf "https://astral.sh/uv/$R_UV_VERSION/install.sh" | sh
fi
