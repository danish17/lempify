#! /bin/bash
PROJECT_ROOT=$(pwd)

# IMPORTS
. "src/welcome.sh"
. "src/messages.sh"
. "src/bootstrap.sh"
. "src/validator.sh"
. "src/installer.sh"
. "src/cleanup.sh"
. "src/wordpress-scripts/install-wpcli.sh"
. "src/nginx-scripts/setup-default-site.sh"
. "src/nginx-scripts/service-status.sh"

welcome
bootstrap
validate
install
if [ $? -eq 0 ]; then
	maybe_run_nginx
	install_supp
	setup_site
else
	warning "Installation has faced some errors. Please check the logs for more information."
fi
cleanup