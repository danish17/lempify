#! /bin/bash

##
# function does_example_work()
# checks if the test site is working
# returns 0 if the site is working, 1 otherwise
##
function does_example_work() {
	HEAD example.local | grep '200\ OK' | wc -l >> /dev/null
	if [ $? -eq 0 ]; then
		return 0
	else
		return 1
	fi
}