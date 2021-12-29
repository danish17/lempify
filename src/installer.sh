#! /bin/bash

##
# function install()
# installs the required packages
# returns 0 if the installations were successful; 1 otherwise
##
function install() {
	HAS_ERRORS=0
	if  [ ! $IS_NGINX_INSTALLED ] ; then
		step "Installing Nginx..."
		sudo apt-get install nginx -y
		if [ $? -ne 0 ]; then
			HAS_ERRORS=1
			error "Failed to install Nginx."
			echo "[$(date)] - Failed to install Nginx." >> "$PROJECT_ROOT/logs/$filename" 2>&1
		else
			success "Nginx installed successfully."
		fi
	fi

	if [ ! $IS_PHP_INSTALLED ] ; then 
		step "Installing PHP..."
		sudo apt-get install php-fpm php-cli php-mysql php-curl php-gd php-mcrypt php-imagick php-intl -y
		if [ $? -ne 0 ]; then
			HAS_ERRORS=1
			error "Failed to install PHP."
			echo "[$(date)] - Failed to install PHP." >> "$PROJECT_ROOT/logs/$filename" 2>&1
		else
			success "PHP installed successfully."
		fi
	fi

	if [ ! $IS_MYSQL_INSTALLED ] ; then
		step "Installing MySQL..."
		sudo apt-get install mysql-server -y
		if [ $? -ne 0 ]; then
			HAS_ERRORS=1
			error "Failed to install MySQL."
			echo "[$(date)] - Failed to install MySQL." >> "$PROJECT_ROOT/logs/$filename" 2>&1
		else
			success "MySQL installed successfully."
		fi
	fi

	return HAS_ERRORS
}