#! /bin/bash

##
# function cleanup()
# performs cleanup after script run
##
function cleanup() {
	if [ -d "$PROJECT_ROOT/tmp" ]; then
		step "Cleaning up..."
		step "Removing tmp directory..."
		rm -rf "$PROJECT_ROOT/tmp"
		if [ $? -eq 0 ]; then
			success "tmp directory removed."
		else
			warning "tmp directory could not be removed."
			echo "[$(date)] - tmp directory could not be removed." >> "$PROJECT_ROOT/logs/$filename" 2>&1
		fi
	fi
}
