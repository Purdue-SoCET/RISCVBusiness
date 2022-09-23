#! /bin/sh

RED='\033[0;31m'
BLUE='\033[0;34m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

info_print() {
  echo -e "$BLUE$1$NC"
}

error_print() {
  echo -e "$RED$1$NC"
}

success_print() {
  echo -e "$GREEN$1$NC"
}

echo "Initializing Repository..."

if [ -d "./fusesoc_libraries" ] ; then
  rm -rf ./fusesoc_libraries # clean old fusesoc libs
  rm ./fusesoc.conf
fi

info_print "Installing Digital Libraries"
if ! fusesoc library add digital-lib git@github.com:Purdue-SoCET/digital-lib.git ; then
  error_print "Failed to fetch digital-lib: ensure that ssh key is set up for repository permissions"
  exit 1
fi

info_print "Installing pre-commit hook"
cp ./scripts/pre-commit ./.git/hooks/

success_print "Initialization Complete!"