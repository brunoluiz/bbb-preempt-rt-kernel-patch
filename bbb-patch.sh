#!/bin/bash

option=$1
arg=$2
source vars.sh # Extern vars

help_menu () {
	echo 
	echo "OSADL BBB Kernel 3.12 auto-generator"
	echo "===================================="
	echo "Arguments:"
	echo
	echo "- help: show this window"
    echo "- start $2: start the process (pass the /dev/* as second argument!)"
    echo "- clean: clean 'start' generated folders"
    echo "- clean-all: clean 'start' generated files, including downloaded"
	echo
    exit
}

start () {
	if [ -z $arg ]; then 
		echo "Missing argument! You need to specify the /dev/*!"
		exit
	fi

	echo
	echo "Starting process... Go and make some coffee now"
	echo "[MAIN] device=$arg"
	echo "[MAIN] linuxpath=$linuxpath"
	echo "................................................"
	echo 

	./requeriments.sh
	./osadl-patch.sh $linuxpath
	./compile-kernel.sh $linuxpath
	./clone-image.sh $arg
	./transfer.sh $arg $linuxpath

	echo "Just boot now!"
}

clean_generated () {
	rm -rf kernel
	rm -rf linux_modules
}

clean_cached () {
	rm -rf downloads/*
}

if [ -z $option ]; then 
	echo "Missing command! Check 'help' for the list of commands!"
	exit
elif [ $option == "help" ]; then 
    help_menu
elif [ $option == "start" ]; then 
	start
elif [ $option == "clean" ]; then 
	clean_generated
	exit
elif [ $option == "clean-all" ]; then 
	clean_generated
	clean_cached
	exit
else
	echo "Wrong command! Check 'help' for the list of commands!"
    exit
fi
