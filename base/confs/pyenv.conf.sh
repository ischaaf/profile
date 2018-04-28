# Initialize pyenv
if which pyenv >/dev/null 2>&1; then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)" > /dev/null 2>&1
  export PYENV_VIRTUALENV_DISABLE_PROMPT=1 > /dev/null 2>&1
fi
export PYTHONSTARTUP="$HOME/.pythonrc.py"
