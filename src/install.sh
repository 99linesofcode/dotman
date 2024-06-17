#!/bin/bash

shopt -s nullglob

# automatically enable colors when pacman’s output is on a tty.
sudo sed -i 's/#Color/Color' /etc/pacman.conf

OVERRIDE_PATH="$DOTMAN_PATH/packages"
SOURCE_PATH="$DOTMAN_PATH/src/packages"

source $DOTMAN_PATH/src/library.sh

figlet Installer

for script in $(_getScripts); do _runScript $script; done

