#! /bin/bash

# IMPORTS
. "$PROJECT_ROOT/src/messages.sh"

###
# function bootstrap()
# bootstraps the project
###
function bootstrap() {
	step 'Checking permissions...'
	if [ "$EUID" -ne 0 ] ; then 
		error "Please run the script as root."
  		exit 1
	else
		success "Permissions OK."
	fi

	step 'Creating Logfile...'
	filename="run-$(date +%s).log" # needs a better logic to create a unique filename; currently will create a new file everytime the script is run"
	mkdir -p $PROJECT_ROOT/logs && echo '' > "$PROJECT_ROOT/logs/$filename"
	if [ $? -eq 0 ]; then
		success 'Logfile created.'
	else
		error 'Error creating logfile; proceeding without one.'
	fi

	step 'Setting up permissions...'
	chmod +x $PROJECT_ROOT/src/*.sh >> "$PROJECT_ROOT/logs/$filename" 2>&1

	if [ $? -eq 0 ]; then
		success 'Permissions set.'
	else
		error 'Error setting up permissions.'
		warning 'Check logs for more information.'
		exit 1
	fi
}
