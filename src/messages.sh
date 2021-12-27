#! /bin/bash

###
# function success()
# prints a success message
# @param $1 message
###
function success() {
	echo -e "\033[38;5;2m ✓ $1\033[0m"
}

###
# function warning()
# prints a warning message
# @param $1 message
###
function warning() {
	echo -e "\033[38;5;3m ⚠ $1\033[0m"
}

###
# function error()
# prints a error message
# @param $1 message
###
function error() {
	echo -e "\033[38;5;1m ✗ $1\033[0m"
}