#!/usr/bin/env bash

set -eEu -o pipefail

test -f "$HOME/bin/bat" || ln -s /usr/bin/batcat "$HOME/bin/bat"

(
    mkdir -p "$(bat --config-dir)"
    cd "$(bat --config-dir)"
    mkdir -p themes

    if [[ ! -d themes/dracula-sublime ]]; then
        git clone https://github.com/dracula/sublime.git themes/dracula-sublime
        bat cache --build
    fi
)
