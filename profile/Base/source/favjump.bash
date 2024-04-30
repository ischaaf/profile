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

function fav-add() {
    local name="${1:?must pass a name}"
    local target="$PWD"

    __favjump_parse_file
    for n in "${!FAVJUMP_LOCATIONS[@]}"; do
        local t="${FAVJUMP_LOCATIONS[$n]}"
        if [[ "$n" == "$name" ]]; then
            echo "favorite name $name already exists (maps to: $t)"
            return 1
        elif [[ "$t" == "$target" ]]; then
            echo "target $target already favorited under $n"
            return 1
        fi
    done

    echo "$name:$target" >> "$FAVJUMP_FILE"
    echo "Saved favorite $name -> $target in $FAVJUMP_FILE"

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
