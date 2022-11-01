#!/usr/bin/env bash

set -eu -o pipefail

if [[ ! -d "$PROFILE_TOOL_DIR/pyenv" ]]; then
    git clone https://github.com/pyenv/pyenv.git "$PROFILE_TOOL_DIR/pyenv"
else
    (
        pushd "$PROFILE_TOOL_DIR/pyenv"
        git checkout master
        git pull
        git checkout "v2.3.0"
    )
fi

if [[ ! -d "$PROFILE_TOOL_DIR/pyenv/plugins/pyenv-virtualenv" ]]; then
    git clone https://github.com/pyenv/pyenv-virtualenv.git "$PROFILE_TOOL_DIR/pyenv/plugins/pyenv-virtualenv"
fi

PROFILE_PYTHON_VERSION="3.10.4"
TEMP_PYENV="$PROFILE_TOOL_DIR/pyenv/bin/pyenv"
export PYTHONSTARTUP="$HOME/.pythonrc.py"
export PYENV_ROOT="$PROFILE_TOOL_DIR/pyenv"

if ! "$TEMP_PYENV" versions | grep "$PROFILE_PYTHON_VERSION"; then
    "$TEMP_PYENV" install "$PROFILE_PYTHON_VERSION"
fi

"$TEMP_PYENV" global "$PROFILE_PYTHON_VERSION"
