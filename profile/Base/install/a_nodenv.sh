#!/usr/bin/env bash

set -eu -o pipefail

export INST_NODE_VERSION="22.14.0"

if [[ ! -d "$PROFILE_TOOL_DIR/nodenv" ]]; then
    git clone https://github.com/nodenv/nodenv.git "$PROFILE_TOOL_DIR/nodenv"
fi

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

if ! "$TEMP_NODENV" versions | grep -q "$INST_NODE_VERSION"; then
    "$TEMP_NODENV" install "$INST_NODE_VERSION"
fi

"$TEMP_NODENV" global "$INST_NODE_VERSION"

(
    export PATH="$HOME/.nodenv/versions/$INST_NODE_VERSION/bin:$PATH"
    npm install -g typescript-language-server
    npm install -g bash-language-server
)
