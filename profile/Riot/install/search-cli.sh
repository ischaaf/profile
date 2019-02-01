#!/usr/bin/env bash

set -eu -o pipefail

CLI_PATH="$HOME/code/egh.riotgames.com/kda/search-cli/target/release/search-cli"

# shellcheck disable=SC2015
test -f "$CLI_PATH" && ln -s "$CLI_PATH" "$HOME/bin/search-cli" || :
