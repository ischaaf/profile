if [ -d "$HOME/local/homebrew/bin" ]; then
  export PATH="$HOME/local/homebrew/bin:$PATH:$HOME/local/homebrew/sbin"
fi
. ~/.profile.d/init
. ~/.profile.d/users/kburton/kyle.burton.conf

export PATH
alias s='cd ..'

. $HOME/.profile.d/users/kburton/kyle.burton.conf

export RUBYLIB="$RUBYLIB:$HOME/projects/rn-extutils/relay-gems/lib"
