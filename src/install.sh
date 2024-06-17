#!/bin/bash

shopt -s nullglob

# automatically enable colors when pacman’s output is on a tty.
sudo sed -i 's/#Color/Color' /etc/pacman.conf

figlet Installer

