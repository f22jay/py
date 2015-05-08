#!/bin/bash
###shell下的debug工具，like exception栈

debug_mode=1
msg() {
    printf '%b\n' "$1" >&2
}

success() {
    if [ "$ret" -eq '0' ]; then
    msg "\e[32m[✔]\e[0m ${1}${2}"
fi
}

error() {
    msg "\e[31m[✘]\e[0m ${1}${2}"
    exit 1
}

debug() {
	echo "xx" $xx
    if [ "$debug_mode" -eq '1' ] && [ "$ret" -gt '0' ]; then
      msg "An error occurred in function \"${FUNCNAME[$i]}\" on line ${BASH_LINENO[$i]}, we're sorry for that."
      msg "An error occurred in function \"${FUNCNAME[$i+1]}\" on line ${BASH_LINENO[$i+1]}, we're sorry for that."
    fi
}


func(){
	find ~ | grep "sssssSDF"
	ret=$?
	xx=3
	debug ret xx
}


func



