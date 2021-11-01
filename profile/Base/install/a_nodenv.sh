#!/usr/bin/env bash

set -eu -o pipefail

if [[ ! -d "$PROFILE_TOOL_DIR/nodenv" ]]; then
    git clone https://github.com/nodenv/nodenv.git "$PROFILE_TOOL_DIR/nodenv"
fi

(
    cd "$PROFILE_TOOL_DIR/nodenv" && src/configure && make -C src
)

if [[ ! -f "$HOME/bin/nodenv" ]]; then
    ln -s "$PROFILE_TOOL_DIR/nodenv/bin/nodenv" "$HOME/bin/nodenv"
fi
