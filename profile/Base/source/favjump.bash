#!/usr/bin/env bash

DEFAULT_FAVJUMP_FILE="$HOME/.favjumprc"
export FAVJUMP_FILE="${FAVJUMP_FILE:-$DEFAULT_FAVJUMP_FILE}"

declare -A FAVJUMP_LOCATIONS

function __favjump_parse_file() {
    if [[ ! -f "$FAVJUMP_FILE" ]]; then
        echo "Failed to find favjump file: ${FAVJUMP_FILE}"
        return 1
    fi

    # wipe the map
    unset FAVJUMP_LOCATIONS
    declare -gA FAVJUMP_LOCATIONS

    local name target
    while read -r line; do
        name="${line%%:*}"
        target="${line##*:}"
        # echo "adding ${name}=${target}"
        FAVJUMP_LOCATIONS[$name]="$target"
    done < "$FAVJUMP_FILE"
}

function fav() {
    if [[ -z "${1:-}" ]]; then
        echo "must pass argument"
        return 1
    fi
    __favjump_parse_file
    local target
    target="${FAVJUMP_LOCATIONS[$1]}"
    if [[ -z "$target" ]]; then
        echo "Failed to find target: $1"
        return 1
    fi
    cd "$target" || return 1
}

function __favjump_completions() {
    if  [[ "${#COMP_WORDS[@]}" -ge 3 ]]; then
        return
    fi

    __favjump_parse_file
    COMPREPLY=($(compgen -W "${!FAVJUMP_LOCATIONS[*]}"  -- "${COMP_WORDS[1]}"))
}

__favjump_completions
complete -F __favjump_completions fav
