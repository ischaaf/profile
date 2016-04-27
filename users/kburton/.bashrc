if [ -d "$HOME/bin" ]; then
  export PATH="$HOME/bin:$PATH"
fi

if [ -d "$HOME/local/homebrew/bin" ]; then
  export PATH="$HOME/local/homebrew/bin:$PATH:$HOME/local/homebrew/sbin"
fi

if [ -d "/usr/local/mysql/bin" ]; then
  export PATH="$PATH:/usr/local/mysql/bin"
fi

test -f /etc/bashrc && . /etc/bashrc
. ~/.profile.d/init
. ~/.profile.d/users/kburton/kyle.burton.conf

export PATH
alias s='cd ..'

if [ -d /usr/local/opt/coreutils/libexec/gnubin ]; then
  PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
fi

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

if [ -d /usr/local/sbin ]; then
  export PATH="$PATH:/usr/local/sbin"
fi

if [ -e $HOME/software/env.go ]; then
  source $HOME/software/env.go
fi


if [ -e "$HOME/bin/.bake-completion.sh" ]; then
  source "$HOME/bin/.bake-completion.sh"
fi

if which pyenv >/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

if [ -d "$HOME/.env.local" ]; then
  for f in "$HOME/.env.local/*"; do
    source $f
  done
fi

# http://stackoverflow.com/questions/1348842/what-should-i-set-java-home-to-on-osx
if [ -x /usr/libexec/java_home ]; then
  export JAVA_HOME=$(/usr/libexec/java_home)
fi

# NB: on OSX / Darwin, we want to use the brew installed vim if its present
if [ "Darwin" = "$(uname)" ]; then
  if [ -e /usr/local/bin/vim ]; then
    alias vim='/usr/local/bin/vim'
  fi
fi

if [ -d ~/.bash.d ]; then
  for f in ~/.bash.d/*; do
    if [ -e "$f" ]; then
      source "$f"
    fi
  done
fi
