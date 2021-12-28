#! /bin/bash
PROJECT_ROOT=$(pwd)

# IMPORTS
. "src/welcome.sh"
. "src/messages.sh"
. "src/bootstrap.sh"
. "src/validator.sh"
. "src/installer.sh"
. "src/cleanup.sh"
. "src/nginx-scripts/setup-default-site.sh"

welcome
bootstrap
validate
install
setup_site