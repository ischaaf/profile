#!/usr/bin/env bash

set -eEu -o pipefail

test -f "$HOME/bin/bat" || ln -s /usr/bin/batcat "$HOME/bin/bat"

(
    mkdir -p "$(batcat --config-dir)"
    cd "$(batcat --config-dir)"
    mkdir -p themes

    if [[ ! -d themes/dracula-sublime ]]; then
        git clone https://github.com/dracula/sublime.git themes/dracula-sublime
        batcat cache --build
    fi
)
