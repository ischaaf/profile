if [ -d "$HOME/local/homebrew/bin" ]; then
  export PATH="$HOME/local/homebrew/bin:$PATH:$HOME/local/homebrew/sbin"
fi
. ~/.profile.d/init

export PATH
alias s='cd ..'
alias emacs="TERM='xterm-256color' emacs -nw"


. $HOME/.profile.d/users/kburton/kyle.burton.conf

export RUBYLIB="$RUBYLIB:$HOME/projects/rn-extutils/relay-gems/lib"

export PATH="$PATH:/opt/node/bin:$HOME/node_modules/.bin"

export PATH="$PATH:/opt/zookeeper/bin"
