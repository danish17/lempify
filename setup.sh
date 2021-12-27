#! /bin/bash
PROJECT_ROOT=$(pwd)

# IMPORTS
. "src/welcome.sh"
. "src/messages.sh"
. "src/bootstrap.sh"
. "src/validator.sh"
. "src/cleanup.sh"

welcome
bootstrap
validate