if [ -d "$HOME/local/homebrew/bin" ]; then
  export PATH="$HOME/local/homebrew/bin:$PATH:$HOME/local/homebrew/sbin"
fi
test -f /etc/bashrc && . /etc/bashrc
. ~/.profile.d/init
. ~/.profile.d/users/kburton/kyle.burton.conf

export PATH
alias s='cd ..'

. $HOME/.profile.d/users/kburton/kyle.burton.conf

export RUBYLIB="$RUBYLIB:$HOME/projects/rn-extutils/relay-gems/lib"

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
#rvm use 1.8.7 >/dev/null 2>&1

if [ -e $HOME/projects/dev-utils/instago/env.go ]; then
  source $HOME/projects/dev-utils/instago/env.go
fi

DIOCEAN_COMPLETION="$GOPATH/src/github.com/kyleburton/diocean/scripts/diocean-completion.bash"
if [ -e $DIOCEAN_COMPLETION ]; then
  source $DIOCEAN_COMPLETION
fi


export PATH="$PATH:/opt/node/bin"
