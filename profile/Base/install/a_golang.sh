#!/usr/bin/env bash

set -eu -o pipefail
INSTALL_GO_VERSION="1.18"

if [[ -d "/usr/local/go" ]]; then
    CURRENT_GO_VERSION="$(go version)"
    if [[ "$CURRENT_GO_VERSION" == "$INSTALL_GO_VERSION" ]]; then
        exit 0
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
