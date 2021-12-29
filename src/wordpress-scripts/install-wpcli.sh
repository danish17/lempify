#! /bin/bash

function install_wpcli() {
	mkdir -p $PROJECT_ROOT/tmp && curl -o $PROJECT_ROOT/tmp/wp-cli.phar https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
	if [ $? -ne 0 ]; then
		error "Failed to download WP-CLI."
		echo "[$(date)] - Failed to download WP-CLI." >> "$PROJECT_ROOT/logs/$filename" 2>&1
		return 1
	else
		success "WP-CLI downloaded successfully."
	fi

	chmod +x $PROJECT_ROOT/tmp/wp-cli.phar
	sudo mv $PROJECT_ROOT/tmp/wp-cli.phar /usr/local/bin/wp
	if [ $? -ne 0 ]; then
		error "Failed to install WP-CLI."
		echo "[$(date)] - Failed to install WP-CLI." >> "$PROJECT_ROOT/logs/$filename" 2>&1
		return 1
	else
		success "WP-CLI installed successfully."
		return 0
	fi
}