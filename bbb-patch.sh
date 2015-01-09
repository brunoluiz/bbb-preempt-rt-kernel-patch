#!/bin/bash

linuxpath="linux-3.12.31-rt45"
option=$1
arg=$2

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
	echo "[MAIN] device=$device"
	echo "[MAIN] linuxpath=$linuxpath"
	echo "................................................"
	echo 

	./requeriments.sh
	./osadl-patch.sh $linuxpath
	./compile-kernel.sh $linuxpath
	./transfer.sh $arg

	echo "Just boot now!"
}

clean_generated () {
	rm -rf linux-3.12.31-rt45
	rm -rf linux-3.12.31
	rm -rf linux_modules
}

clean_cached () {
	rm linux-3.12.31.tar.xz
	rm bone-debian-7.5-2014-05-14-2gb.img
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