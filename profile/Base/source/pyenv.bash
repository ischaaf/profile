#!/usr/bin/env bash
# Initialize pyenv

export PYENV_ROOT="$PROFILE_TOOL_DIR/pyenv"
_add_path "$PYENV_ROOT/bin"
if ! command -v pyenv >/dev/null 2>&1; then
    return
fi

# export PYENV_VIRTUALENV_DISABLE_PROMPT=1
# export PYTHONSTARTUP="$HOME/.pythonrc.py"
# eval "$(pyenv init -)"
# eval "$(pyenv init --path)"
# eval "$(pyenv virtualenv-init -)"
