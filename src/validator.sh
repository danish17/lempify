#! /bin/bash

###
# validate()
# checks if there are any existing installations
###
function validate() {
	check_linux_distribution
	if [ $? -ne 0 ]; then
		exit 1
	fi
}

###
# check_linux_distribution()
# checks if the linux distribution is supported
###
function check_linux_distribution() {
	step 'Checking Linux distribution...'
	if [ -f /etc/os-release ]; then
		. /etc/os-release
		if [ "$ID" == "ubuntu" ]; then
			success 'Ubuntu detected.'
			return 0
		elif [ "$ID" == "zorin" ]; then
			success 'Zorin detected.'
			return 0
		else
			error 'Unsupported Linux distribution.'
			echo "'$ID' is not supported." >> "$PROJECT_ROOT/logs/$filename" 2>&1
			return 1
		fi
	else
		error 'Unsupported Linux distribution.'
		echo 'No /etc/os-release file found.' >> "$PROJECT_ROOT/logs/$filename" 2>&1
		return 1
	fi
}