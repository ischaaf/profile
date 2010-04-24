USR="$1"

if [ -z "$USR" ]; then
  echo "Error: you must supply a user for installation"
  exit -1
fi

test -e $HOME/.gitconfig || ln -s $HOME/.profile.d/$USR/.gitconfig $HOME/.gitconfig
test -e $HOME/.profile   || ln -s $HOME/.profile.d/$USR/.profile $HOME/.profile
test -e $HOME/.bashrc    || ln -s $HOME/.profile.d/$USR/.bashrc $HOME/.bashrc
test -e $HOME/.screenrc  || ln -s $HOME/.profile.d/$USR/.screenrc $HOME/.screenrc

