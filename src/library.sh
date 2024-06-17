#!/bin/bash

array::filter() {
    local callback=$1
    local matches=()
    shift

    for el in $@; do
        if "$callback" "$el"; then
            matches+=($el)
        fi
    done

    echo "${matches[@]}"
}

#
#
#

_getScripts() {
    scripts=$(find "$SOURCE_PATH/$1" "$OVERRIDE_PATH/$1" -maxdepth 1 -type f -name "*.sh" -exec basename {} .sh \; | uniq)

    # get package .ignore
    mapfile -t ignored <"$DOTMAN_PATH/.ignore"

    isIgnored() {
        [[ ! "${ignored[@]}" =~ $1 ]]
    }

    array::filter isIgnored "${scripts[@]}"
}

_runScript() {
    [[ -f "$OVERRIDE_PATH/$1.sh" ]] && source "$OVERRIDE_PATH/$1.sh" || source "$SOURCE_PATH/$1.sh"
}
