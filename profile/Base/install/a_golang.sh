#!/usr/bin/env bash

set -eu -o pipefail

if [[ -d "/usr/local/go" ]]; then
    exit 0
fi

wget https://golang.org/dl/go1.17.3.linux-amd64.tar.gz
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.17.3.linux-amd64.tar.gz
rm -f go1.17.3.linux-amd64.tar.gz

(
    export GOROOT=/usr/local/go
    export GOPATH="$HOME/code"
    export PATH="$GOROOT/bin:$GOPATH/bin:$PATH"
    GO111MODULE=on go get golang.org/x/tools/gopls@latest
)
