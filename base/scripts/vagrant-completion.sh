#!/bin/bash

_vagrant_completion() {
  local cur prev commands
  COMPREPLY=()
  cur="${COMP_WORDS[COMP_CWORD]}"
  prev="${COMP_WORDS[COMP_CWORD-1]}"
  commands='box destroy halt package provision reload resume ssh ssh_config status suspend up version init help'

  case "${prev}" in
    box | destroy | halt | package | provision | reload | resume | ssh | ssh_config | status | suspend | up | version | init)
    COMPREPLY=()
    ;;
    help)
    # Show tasks again, but only once; don't infinitely recurse
    local prev2="${COMP_WORDS[COMP_CWORD-2]}"
    if [ "$prev2" == "help" ]; then
      COMPREPLY=()
    else
      COMPREPLY=( $(compgen -W "${commands}" -- ${cur}) )
    fi
    ;;
    vagrant)
    COMPREPLY=( $(compgen -W "${commands}" -- ${cur}) )
    ;;
  esac

  return 0
}

complete -F _vagrant_completion vagrant
