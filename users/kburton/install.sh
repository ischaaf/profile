set -e
set -x

test -d $HOME/bin || mkdir $HOME/bin
for util in $HOME/.profile.d/users/kburton/bin/*; do
  test -f $HOME/bin/$(basename $util) || ln -s $util $HOME/bin/$(basename $util)
done

if [ ! -d $HOME/.vim ]; then
  ln -s $HOME/.profile.d/users/kburton/vim $HOME/.vim
  test -d $HOME/.vim/backup      || mkdir $HOME/.vim/backup
  test -d $HOME/.vim/backup/swap || mkdir $HOME/.vim/backup/swap
fi
