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

_addUserToGroup() {
    if ! groups | grep -q "$1"; then
        sudo usermod -aG "$1"
        echo ":: $(whoami) added to group $1"
    fi
}

_configureDefaultApplication() {
    echo "$2" >"$DOTMAN_PATH/.settings/$1.sh"
}

_installPackage() {
    # TODO make sure /etc/pacman.conf colors is enabled globally
    if [[ -n $(yay -Q $1) ]]; then
        echo ":: $1 is already installed."
        return
    fi

    yay --noconfirm -S "$1"
}

_startService() {
    if ! systemctl is-enabled -q "$1" || ! systemctl is-active -q "$1"; then
        systemctl enable --now "$1"
        echo ":: $1 enabled and active"
    fi
}

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
