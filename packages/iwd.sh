source $DOTMAN_PATH/src/library.sh

_installPackage "iwd"

_addUserToGroup "wheel"

_startService "iwd.service"
