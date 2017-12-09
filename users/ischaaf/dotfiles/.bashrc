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

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
#rvm use 1.8.7 >/dev/null 2>&1

# In WSL we need to connect to the host machine's docker daemon
# Since we can run windows binaries directly, we'll just link docker's
# Bin on our path
PATH="$PATH:/mnt/c/Program\ Files/Docker/Docker/resources/bin"
#alias docker=docker.exe
#export DOCKER_HOST="tcp://0.0.0.0:2375"
# mount /mnt/c to /c if not already done
if [ ! -d "/c" ] || [ ! "$(\ls /c)" ]; then
  echo "Requiring root password to $(tput setaf 6)mount --bind /mnt/c /c$(tput sgr 0)"
  sudo mkdir -p /c
  sudo mount --bind /mnt/c /c
fi

# Change from /mnt/c/... to /c/...
if [ "$(pwd | cut -c -7)" == "/mnt/c/" ]; then
  cd "$(pwd | cut -c 5-)"
fi

# Provide docker for bash and docker-compose
docker() {
  docker.exe "$@"
}
# if [ -e $HOME/personal/projects/dev-utils/instago/env.go ]; then
#   source $HOME/personal/projects/dev-utils/instago/env.go
# fi

DIOCEAN_COMPLETION="$GOPATH/src/github.com/kyleburton/diocean/scripts/diocean-completion.bash"
if [ -e $DIOCEAN_COMPLETION ]; then
  source $DIOCEAN_COMPLETION
fi


export PATH="$PATH:/opt/node/bin"

if [ -d /usr/local/sbin ]; then
  export PATH="$PATH:/usr/local/sbin"
fi

if [ -e "$HOME/bin/.bake-completion.sh" ]; then
  source "$HOME/bin/.bake-completion.sh"
fi

if which pyenv >/dev/null 2>&1; then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)" > /dev/null 2>&1
  export PYENV_VIRTUALENV_DISABLE_PROMPT=1 > /dev/null 2>&1
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
elif [ "Linux" = "$(uname)" ]; then
  if [ -f "$HOME/.linuxbrew/bin/vim" ]; then
    alias vim="$HOME/.linuxbrew/bin/vim"
  fi
fi

if [ -f "$HOME/.linuxbrew/bin/screen" ]; then
  alias screen="$HOME/.linuxbrew/bin/screen"
fi

if [ -d ~/.bash.d ]; then
  for f in ~/.bash.d/*; do
    if [ -e "$f" ]; then
      source "$f"
    fi
  done
fi

if [ -d ~/.cargo/bin ]; then
  export PATH="$PATH:~/.cargo/bin"
fi

export PAGER="${PAGER:-less}"

if [ -e /usr/local/bin/aws_completer ]; then
  complete -C '/usr/local/bin/aws_completer' aws
fi

export GOPATH="$HOME/software/go"
export PATH="$PATH:$GOPATH/bin"
