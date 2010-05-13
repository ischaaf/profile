set -e
set -x

test -d $HOME/bin || mkdir $HOME/bin
test -f $HOME/bin/xpath || ln -s $HOME/.profile.d/users/kburton/bin/xpath $HOME/bin/xpath
test -f $HOME/bin/rec-view || ln -s $HOME/.profile.d/users/kburton/bin/rec-view $HOME/bin/rec-view
