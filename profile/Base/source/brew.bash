#!/usr/bin/env bash
# shellcheck disable=SC1090

if ! command -v brew >/dev/null 2>&1; then
  return
fi

if [ -f "$(brew --prefix)/Cellar/bash-completion/bash_completion" ]; then
  . "$(brew --prefix)/Cellar/bash-completion/bash_completion"
fi

if [ -f "$(brew --prefix)/Cellar/bake-completion/bake-completion.sh" ]; then
  . "$(brew --prefix)/Cellar/bake-completion/bake-completion.sh"
fi
