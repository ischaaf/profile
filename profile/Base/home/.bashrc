# Call profile initialization
test -f /etc/bashrc && . /etc/bashrc
. ~/.profile.d/init

# General Exports

function _get_prompt () {
  local d, in_screen
  d="${PWD##*/}"
  in_screen="$(screen -ls | grep "$d" >/dev/null 2>&1 && " (screen)" || "")"
  echo -ne "\033];$d$in_screen\007"
}

# Set iTerm prompt
if [ "$ITERM_SESSION_ID" ]; then
  export PROMPT_COMMAND='echo -ne "\033];${PWD##*/}\007"; '
fi

# Modify Path
_add_path "/usr/local/opt/coreutils/libexec/gnubin"
_add_path "$HOME/local/homebrew/bin"
_add_path "$HOME/local/homebrew/sbin"
_add_path "/usr/local/mysql/bin"
_add_path "$HOME/.rvm/bin"
_add_path "/opt/node/bin"
_add_path "/usr/local/sbin"
_add_path "$GOPATH/bin"

# Source .bash.d
if [ -d ~/.bash.d ]; then
  for f in ~/.bash.d/*; do
    if [ -e "$f" ]; then
      source "$f"
    fi
  done
fi
