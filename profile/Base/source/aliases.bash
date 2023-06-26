#!/usr/bin/env bash
# Various Exports
export RSYNC_RSH="ssh"
export GREP_COLOR='1;32'
export GOPATH="$HOME/software/go"
export PAGER="${PAGER:-less -RS}"
export HISTCONTROL="ignoreboth"
export EDITOR="nvim"

function _tmux_session () {
    if command -v tmux >/dev/null 2>&1; then
        tmux display-message -p '#S' 2>/dev/null
    fi
}

__tmux_session="$(_tmux_session)"
if [[ -n "$TMUX_PANE" ]]; then
    export HISTFILE="$HOME/.hists/${__tmux_session}_${TMUX_PANE}"
fi

# Aliases
alias s='cd ..'
alias rm='rm -i'
alias rsync='rsync -v --progress --partial'
alias less="less -RS"
alias grep="grep --color=auto"
alias p4=p4.exe

function cdl () {
    cd "$(wslpath "$1")"
}

function pushdl () {
    pushd "$(wslpath "$1")"
}
