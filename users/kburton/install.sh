set -e
set -x

test -d $HOME/bin || mkdir $HOME/bin
test -f $HOME/bin/xpath || ln -s $(dirname $0)/bin/xpath $HOME/bin/xpath
