#!/usr/bin/env bash

if [ -f /home/ischaaf/.linuxbrew/share/bash-completion/bash_completion ]; then
  . /home/ischaaf/.linuxbrew/share/bash-completion/bash_completion
fi

if [ -f /home/ischaaf/.linuxbrew/bin/bake-completion.sh ]; then
  . /home/ischaaf/.linuxbrew/bin/bake-completion.sh
fi

if [ -f /home/linuxbrew/.linuxbrew/opt/bake/bin/bake-completion.sh ]; then
  . /home/linuxbrew/.linuxbrew/opt/bake/bin/bake-completion.sh
fi
