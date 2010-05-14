set -e
set -x

test -d $HOME/bin || mkdir $HOME/bin
for util in xpath rec-view rabbit; do
  test -f $HOME/bin/$util || ln -s $HOME/.profile.d/users/kburton/bin/$util $HOME/bin/$util
done
