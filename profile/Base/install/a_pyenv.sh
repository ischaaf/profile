#!/usr/bin/env bash

set -eu -o pipefail

if [[ ! -d "$PROFILE_TOOL_DIR/pyenv" ]]; then
    git clone https://github.com/pyenv/pyenv.git "$PROFILE_TOOL_DIR/pyenv"
fi

if [[ ! -d "$PROFILE_TOOL_DIR/pyenv/plugins/pyenv-virtualenv" ]]; then
    git clone https://github.com/pyenv/pyenv-virtualenv.git "$PROFILE_TOOL_DIR/pyenv/plugins/pyenv-virtualenv"
fi

if [[ ! -f "$HOME/bin/pyenv" ]]; then
    ln -s "$PROFILE_TOOL_DIR/pyenv/bin/pyenv" "$HOME/bin/pyenv"
fi
