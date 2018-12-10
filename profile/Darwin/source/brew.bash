#!/usr/bin/env bash

if [ -f /usr/local/Cellar/bash-completion/bash_completion ]; then
  . /usr/local/Cellar/bash-completion/bash_completion
fi

if [ -f /usr/local/Cellar/bake-completion/bake-completion.sh ]; then
  . /usr/local/Cellar/bake-completion/bake-completion.sh
fi

if [ -f /usr/local/Cellar/bake/1.0.11/bin/bake-completion.sh ]; then
  . /usr/local/Cellar/bake/1.0.11/bin/bake-completion.sh
fi
