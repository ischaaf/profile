#!/usr/bin/env bash

_add_path "$HOME/.linuxbrew/bin"
_add_path "/home/linuxbrew/.linuxbrew/bin"

if [ -f /home/ischaaf/.linuxbrew/share/bash-completion/bash_completion ]; then
  . /home/ischaaf/.linuxbrew/share/bash-completion/bash_completion
fi

if [ -f /home/ischaaf/.linuxbrew/bin/bake-completion.sh ]; then
  . /home/ischaaf/.linuxbrew/bin/bake-completion.sh
fi

if [ -f /home/linuxbrew/.linuxbrew/opt/bake/bin/bake-completion.sh ]; then
  . /home/linuxbrew/.linuxbrew/opt/bake/bin/bake-completion.sh
fi

# Use Linuxbrew screen (TODO should be moved to Linux OS)
if [ -f "$HOME/.linuxbrew/bin/screen" ]; then
  alias screen="$HOME/.linuxbrew/bin/screen"
fi

