#!/usr/bin/env bash

set -eu -o pipefail
INSTALL_GO_VERSION="1.19"
INSTALL_VERSION_STRING="go version go$INSTALL_GO_VERSION linux/amd64"

if which go; then
    if [[ -d "/usr/local/go" ]]; then
        CURRENT_GO_VERSION="$(go version)"
        if [[ "$CURRENT_GO_VERSION" == "$INSTALL_VERSION_STRING" ]]; then
            exit 0
        fi
    fi
fi

wget "https://golang.org/dl/go${INSTALL_GO_VERSION}.linux-amd64.tar.gz"
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf "go${INSTALL_GO_VERSION}.linux-amd64.tar.gz"
rm -f "go${INSTALL_GO_VERSION}.linux-amd64.tar.gz"

(
    export GOROOT=/usr/local/go
    export GOPATH="$HOME/code"
    export PATH="$GOROOT/bin:$GOPATH/bin:$PATH"
    go install golang.org/x/tools/gopls@latest
)
