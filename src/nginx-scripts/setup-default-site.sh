#! /bin/bash

# IMPORTS
. "src/tests/post-site-creation.sh"

##
# function setup_test_site()
# creates a php test site with the default nginx config
##
function setup_site() {
  step "Creating test site: http://example.local"
  if [ -f /etc/nginx/sites-available/example.local ]; then
	error "Test site already exists."
	echo "[$(date)] - Test site already exists." >> "$PROJECT_ROOT/logs/$filename" 2>&1
	return 1
  else
	cp "$PROJECT_ROOT/templates/nginx-confs/example.local" /etc/nginx/sites-available/
	step "Enabling test site: http://example.local"
	if [ $? -eq 0 ]; then
		ln -s /etc/nginx/sites-available/example.local /etc/nginx/sites-enabled/example.local
		success "Nginx configuration copied and enabled."
	else
		error "Nginx could not be configured for example site. Exiting gracefully!"
		echo "[$(date)] - Nginx configuration could not be enabled." >> "$PROJECT_ROOT/logs/$filename" 2>&1
		return 1
	fi
	# !END BLOCK!

	step "Copying site files to /var/www/html/example.local"
	mkdir -p /var/www/html/example.local && cp "$PROJECT_ROOT/templates/site-files/index.php" /var/www/html/example.local/
	if [ $? -eq 0 ]; then
		success "Site files copied."
	else
		error "Site files could not be copied. Skipping step..."
		echo "[$(date)] - Site files could not be copied." >> "$PROJECT_ROOT/logs/$filename" 2>&1
		return 1
	fi
	# !END BLOCK!
	
	step "Creating hosts file entry for test site: http://example.local"
	echo "127.0.0.1	example.local" >> /etc/hosts
	if [ $? -eq 0 ]; then
		success "Hosts file entry for test site created."
	else
		error "Hosts file entry for test site could not be created. Skipping step..."
		echo "[$(date)] - Hosts file entry for test site could not be created." >> "$PROJECT_ROOT/logs/$filename" 2>&1
	fi
	# !END BLOCK!

	step "Testing Nginx configuration"
	nginx -t >> /dev/null
	if [ $? -eq 0 ]; then
		success "Nginx configuration test passed."
	else
		error "Nginx configuration test failed. Exiting gracefully..."
		echo "[$(date)] - Nginx configuration test failed. Check `nginx -t` for more information." >> "$PROJECT_ROOT/logs/$filename"
		return 1
	fi
	# !END BLOCK!

	step "Restarting Nginx"
	systemctl restart nginx
	if [ $? -eq 0 ]; then
		success "Nginx restarted."
	else
		error "Nginx could not be restarted. Skipping step..."
		echo "[$(date)] - Nginx could not be restarted (check journalctl)" >> "$PROJECT_ROOT/logs/$filename" 2>&1
		return 1
	fi
	# !END BLOCK!
  fi

	step "Testing if site is OK."
	does_example_work
	if [ $? -eq 0 ]; then
		success "Test site is up."
	else
		error "Test site is not working."
		echo "[$(date)] - Test site is not working." >> "$PROJECT_ROOT/logs/$filename" 2>&1
		return 1
	fi
	# !END BLOCK!

	success "Test site created and configured. Visit http://example.local"
}
