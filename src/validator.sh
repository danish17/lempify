#! /bin/bash

declare -A installation_info

###
# validate()
# checks if there are any existing installations
###
function validate() {
    check_linux_distribution
    if [ $? -ne 0 ]; then
        exit 1
    fi

	check_ports

    check_nginx
    installation_info[IS_NGINX_INSTALLED]=$?

    check_php
    installation_info[IS_PHP_INSTALLED]=$?

    check_mysql
    installation_info[IS_MYSQL_INSTALLED]=$?

	check_wpcli
	installation_info[IS_WPCLI_INSTALLED]=$?
}

###
# check_linux_distribution()
# checks if the linux distribution is supported
###
function check_linux_distribution() {
    step "Checking Linux distribution..."
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        if [ "$ID" == "ubuntu" ]; then
            success "Ubuntu detected."
            return 0
        elif [ "$ID" == "zorin" ]; then
            success "Zorin detected."
            return 0
        else
            error "Unsupported Linux distribution."
            echo "[$(date)] - $ID is not supported." >> "$PROJECT_ROOT/logs/$filename" 2>&1
            return 1
        fi
    else
        error "Unsupported Linux distribution."
        echo "[$(date)] - No /etc/os-release file found." >> "$PROJECT_ROOT/logs/$filename" 2>&1
        return 1
    fi
}


###
# check_nginx()
# checks if nginx is installed
# returns 0 if nginx is not installed; 1 otherwise
###
function check_nginx() {
    step "Checking Nginx..."
    if [ -f /usr/sbin/nginx ]; then
        warning "Nginx installation detected."
        echo "[$(date)] - Nginx installation detected (/usr/sbin/nginx file found)." >> "$PROJECT_ROOT/logs/$filename" 2>&1
        return 1
    else
        success "Nginx not detected."
        return 0
    fi
}

###
# check_mysql()
# checks if mysql is installed
# returns 0 if mysql is not installed; 1 otherwise
###
function check_mysql() {
    step "Checking MySQL..."
    if [ -f /etc/init.d/mysql ]; then
        warning "MySQL installation detected."
        echo "[$(date)] - MySQL installation detected (/etc/init.d/mysql exists)." >> "$PROJECT_ROOT/logs/$filename" 2>&1
        return 1
    else
        success "MySQL not detected."
        return 0
    fi
}

###
# check_php()
# checks if php is installed
# returns 0 if php is not installed; 1 otherwise
###
function check_php() {
    step "Checking PHP..."
    if [ -f /usr/bin/php ]; then
        PHP_VERSION=$(php -r 'echo PHP_VERSION;')
        warning "PHP $PHP_VERSION installation detected."
        echo "[$(date)] - PHP $PHP_VERSION installation detected." >> "$PROJECT_ROOT/logs/$filename" 2>&1
        return 1
    else
        success "PHP not detected."
        return 0
    fi
}

###
# check_wpcli()
# checks if wpcli is installed
# returns 0 if wpcli is not installed; 1 otherwise
###
check_wpcli() {
	step "Checking WP-CLI..."
	if [ -f /usr/local/bin/wp ]; then
		warning "WP-CLI installation detected."
		echo "[$(date)] - WP-CLI installation detected (/usr/local/bin/wp exists)." >> "$PROJECT_ROOT/logs/$filename" 2>&1
		return 1
	else
		success "WP-CLI not detected."
		return 0
	fi
}

###
# check_ports()
# checks if port 80 is available
###
check_ports() {
	step "Checking port 80 availability..."
	lsof -i:80 > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		error "Port 80 is already in use. Please free the port and try again."
		echo "[$(date)] - Port 80 is already in use." >> "$PROJECT_ROOT/logs/$filename" 2>&1
		exit 1
	else
		success "Port 80 is free."
	fi
}
