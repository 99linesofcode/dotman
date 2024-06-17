source $DOTMAN_PATH/src/library.sh

_installPackage "networkmanager"

_startService "NetworkManager.service"
