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

if [[ ! -d "$HOME/.nodenv/plugins" ]]; then
    mkdir -p "$HOME/.nodenv/plugins"
fi
if [[ ! -d "$HOME/.nodenv/plugins/node-build" ]]; then
    git clone https://github.com/nodenv/node-build.git "$HOME/.nodenv/plugins/node-build"
fi

TEMP_NODENV="$PROFILE_TOOL_DIR/nodenv/bin/nodenv"

if ! "$TEMP_NODENV" versions | grep -q 16.13.0; then
    "$TEMP_NODENV" install 16.13.0
fi

"$TEMP_NODENV" global 16.13.0

(
    export PATH="$HOME/.nodenv/versions/16.13.0/bin:$PATH"
    npm install -g typescript-language-server
    npm install -g bash-language-server
)
