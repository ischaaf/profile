USR="$1"

if [ -z "$USR" -a -d "$HOME/.profile.d/users/$LOGNAME" ]; then
  USR="$LOGNAME"
fi

if [ -z "$USR" ]; then
  echo "Error: you must supply a user for installation"
  exit -1
fi

_profile_install_symlink () {
  local usr file source_file target_file
  usr=$1
  file=$2

  if [ -z "$usr" -o -z "$file" ]; then
    echo "Error: you must supply a user-dir and a file"
    return -1
  fi

  source_file="$HOME/.profile.d/users/$usr/$file"
  if [ ! -e "$source_file" ]; then
    echo "Error: file: $file does not exist, can't symlink ($source_file)"
    return -1
  fi

  target_file="$HOME/$file"
  if [ ! -e "$target_file" ]; then
    echo "$0: ln -s $source_file $target_file"
    ln -s $source_file $target_file
  fi
}

# symlink all the dotfiles in teh users/$USR directory
for f in ~/.profile.d/users/$USR/.*; do 
  test -d $f && continue
  f=$(basename $f)
  _profile_install_symlink $USR $f
done
 
_profile_install_homebrew_package () {
  binary=$1
  package=$2
  shift; shift
  extra="$@"
  if which "$binary" >/dev/null 2>&1; then
    echo "$0: already installed: $package (already have $binary)"
  else
    echo "$0: installing: $package to get $binary (brew install $package $extra)"
    brew install "$package" $extra
  fi
}

# on osx w/homebrew installed, install some stuff
# TODO: should use chef / chef-solo instead...good enough for now though...
if which brew >/dev/null 2>&1; then
  echo "Installing packages with brew"
  _profile_install_homebrew_package aspell aspell --lang=en
  _profile_install_homebrew_package dict dict 
  _profile_install_homebrew_package git git
  _profile_install_homebrew_package tree tree
fi


# vim customization
test -d $HOME/.vim/backup/swap || mkdir -p $HOME/.vim/backup/swap


if [ -e ~/.profile.d/users/$USR/install.sh ]; then
  cd ~/.profile.d/users/$USR/
  bash install.sh
fi
