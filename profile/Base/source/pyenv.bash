# Initialize pyenv

if ! command -v pyenv >/dev/null 2>&1; then
    return
fi

export PYTHONSTARTUP="$HOME/.pythonrc.py"
export PYENV_ROOT="$(pyenv root)"
eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"
