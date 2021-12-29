#! /bin/bash

##
# function maybe_run_nginx()
# function to check service status
##
function maybe_run_nginx() {
	step "Checking Nginx Service Status..."
	systemctl is-enabled --quiet nginx
	if [ $? -eq 1 ]; then
		success "Nginx is enabled."
	else
		warning "Nginx is not enabled."
		step "Enabling Nginx Service..."
		systemctl enable nginx
	fi

	systemctl is-active --quiet nginx
	if [ $? -eq 1 ]; then
		success "Nginx is running."
	else
		warning "Nginx is not running."
		step "Starting Nginx Service..."
		systemctl start nginx
	fi
}
