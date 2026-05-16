if command -v nodenv >/dev/null; then
    eval "$(nodenv init -)"
fi

_add_path "$(npm -g prefix)/bin"
