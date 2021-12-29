#! /bin/bash

##
# function install()
# installs the required packages
# returns 0 if the installations were successful; 1 otherwise
##
function install() {
	HAS_ERRORS=0
	if  [ ${ installation_info[IS_NGINX_INSTALLED] } -eq 0 ] ; then
		step "Installing Nginx..."
		sudo apt-get install nginx -y >> /dev/null 2>&1
		if [ $? -ne 0 ]; then
			HAS_ERRORS=1
			error "Failed to install Nginx."
			echo "[$(date)] - Failed to install Nginx." >> "$PROJECT_ROOT/logs/$filename" 2>&1
		else
			success "Nginx installed successfully."
		fi
	fi

	if [ ${ installation_info[IS_PHP_INSTALLED] } -eq 0 ] ; then 
		step "Installing PHP..."
		sudo apt-get install php7.4-fpm php7.4-cli php7.4-mysql php7.4-curl -y >> /dev/null 2>&1
		if [ $? -ne 0 ]; then
			HAS_ERRORS=1
			error "Failed to install PHP."
			echo "[$(date)] - Failed to install PHP." >> "$PROJECT_ROOT/logs/$filename" 2>&1
		else
			success "PHP installed successfully."
		fi
	fi

	if [ ${ installation_info[IS_MYSQL_INSTALLED] } -eq 0 ] ; then
		step "Installing MySQL..."
		sudo apt-get install mysql-server -y >> /dev/null 2>&1
		if [ $? -ne 0 ]; then
			HAS_ERRORS=1
			error "Failed to install MySQL."
			echo "[$(date)] - Failed to install MySQL." >> "$PROJECT_ROOT/logs/$filename" 2>&1
		else
			success "MySQL installed successfully."
		fi
	fi

	if [ ${ installation_info[IS_WPCLI_INSTALLED] } -eq 0 ] ; then
		step "Installing WP-CLI..."
		install_wpcli
		if [ $? -ne 0 ]; then
			HAS_ERRORS=1
			error "Failed to install WP-CLI."
			echo "[$(date)] - Failed to install WP-CLI." >> "$PROJECT_ROOT/logs/$filename" 2>&1
		else
			success "WP-CLI installed successfully."
		fi
	fi

	return $HAS_ERRORS
}

function install_supp() {
	apt install libwww-perl >> /dev/null 2>&1
	if [ $? -ne 0 ]; then
		success "libwww-perl installed automatically."
	fi
}