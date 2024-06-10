#! /usr/bin/bash

version=0.0.1

path=$2

help=README.md

help() {
	while IFS= read -r line; do
		echo "$line"
	done <"$help"
}

version() {
	echo $version
}

create_command() {
	echo "create command"
	if test -d $path; then
		echo "Directory exists"
	else
		echo "Directory does not exist"
		mkdir -p $path
		echo "select template"
		echo "1 C"
		echo "2 C++"
		echo "3 C + make"
		echo "4 C++ + make"
		echo "5 C + cmake"
		echo "6 C++ + cmake"
		read -p "Enter your choice: " choice
		case $choice in
		1)
			echo "C template selected"
			if [-d "$path"]; then
				cd "$path" || {echo "failed to change dir to $path"; exit 1;}
				cp -r ~/startp/templates/pureC/* .
				git init
				git add README.md
			else
				echo "Destination path $path does not exist"
				exit 1
			fi 
			;;
		2)
			echo "C++ template selected"
			cd $path
			cp -r ./startp/templates/cpp/* .
			git init
			git add README.md
			;;
		3)
			echo "C + make template selected"
			cd $path
			cp -r ./startp/templates/c_make/* .
			git init
			git add README.md
			;;
		4)
			echo "C++ + make template selected"
			cd $path
			cp -r ./startp/templates/cpp_make/* .
			git init
			git add README.md
			;;
		5)
			echo "C + cmake template selected"
			cd $path
			cp -r ./startp/templates/c_cmake/* .
			git init
			git add README.md
			;;
		6)
			echo "C++ + cmake template selected"
			cd $path
			cp -r ./startp/templates/cpp_cmake/* .
			git init
			git add README.md
			;;
		*)
			echo "Invalid choice"
			;;
		esac
		echo "created project"
	fi
}

case "$OSTYPE" in
darwin*) echo "OSX" ;;
linux*) echo "LINUX" ;;
msys*) echo "WINDOWS" ;;
cygwin*) echo "CYGWIN" ;;
bsd*) echo "BSD" ;;
solaris*) echo "SOLARIS" ;;
*) echo "unknown: $OSTYPE" ;;
esac

if [ "$1" == "create" ]; then
	create_command
fi
if [ "$1" == "version" ]; then
	version
fi
if [ "$1" == "help" ]; then
	help
fi
