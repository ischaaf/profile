if [ -d "$HOME/local/homebrew/bin" ]; then
  export PATH="$HOME/local/homebrew/bin:$PATH:$HOME/local/homebrew/sbin"
fi
. ~/.profile.d/init

export PATH
alias s='cd ..'

. $HOME/.profile.d/users/kburton/kyle.burton.conf
