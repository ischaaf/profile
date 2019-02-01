#!/usr/bin/env bash
# shellcheck disable=SC1090

if ! command -v brew; then
  return
fi

_add_path "$(brew --prefix)/bin"

[ -d "$(brew --prefix)/etc/bash_completion.d" ] && . "$(brew --prefix)/etc/bash_completion.d/"*
[ -f "$(brew --prefix)/bin/opt/bake/bin/bake-completion.sh" ] \
  && . "$(brew --prefix)/bin/opt/bake/bin/bake-completion.sh"
