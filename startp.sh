#! /usr/bin/bash

version=0.0.2
path=$2
help=README.md

function createReadme() {
	cd $path
	touch README.md
	echo "Creating README.md"
	echo "# $path" >README.md
	echo "This is a new project" >>README.md
}

function createMakeFile() {
	cd $path
	touch Makefile
	echo "Creating Makefile"
	echo "CC=gcc" >Makefile
	echo "CFLAGS=-I." >>Makefile
	echo "DEPS = hellomake.h" >>Makefile
	echo "OBJ = hellomake.o hellofunc.o" >>Makefile
	echo "%.o: %.c $(DEPS)" >>Makefile
	echo "	$(CC) -c -o $@ $< $(CFLAGS)" >>Makefile
	echo "hellomake: $(OBJ)" >>Makefile
	echo "	$(CC) -o $@ $^ $(CFLAGS)" >>Makefile
	echo ".PHONY: clean" >>Makefile
	echo "clean:" >>Makefile
	echo "	rm -f *.o hellomake" >>Makefile
}

function createCMakeLists() {
	cd $path
	touch CMakeLists.txt
	echo "Creating CMakeLists.txt"
	echo "cmake_minimum_required(VERSION 3.10)" >CMakeLists.txt
	echo "project(hellomake)" >>CMakeLists.txt
	echo "add_executable(hellomake hellomake.c hellofunc.c)" >>CMakeLists.txt
}

function createGitIgnore() {
	cd $path
	touch .gitignore
	echo "Creating .gitignore"
	echo "build" >.gitignore
	echo "hellomake" >>.gitignore
	echo "*.o" >>.gitignore
}

function createTemplates()
{
  cd ~/.config/
  mkdir templates
  cd templates
  echo "checking templates"
  echo "checking C"
  checkedC=checkDir C
  if [[ checkedC == 0 ]]; then
    echo "C dir exist"
  fi
  checkedCpp=checkDir C++
  if [[ checkedCpp == 0 ]]; then
    echo "C++ dir exist"
  fi
  checkedCplusMake=checkDir CplusMake
  if [[ checkedCplusMake == 0 ]]; then
    echo "C plus make dir exist"
  fi
  checkedCppplusMake=checkDir CppplusMake
  if [[ checkedCppplusMake == 0 ]]; then
    echo "C++ plug make dir exist"
  checkedCplusCmake=checkDir CplusCmake
  if [[ checkedCplusCmake == 0 ]]; then
    echo "C plus Cmake dir exist"
  fi
  checkedCppplusCmake=checkdir CppplusCmake
  if [[checkedCppplusCmake == 0 ]]; then
    echo "C++ plus Cmake dir exist"
  fi
  if [[ checkedC == 1 ]]; then
      mkdir C
      cd C
      mkdir src
      cd src && touch main.c 
      cd ..
      createReadme
      createGitIgnore
  elif [[ checkedCpp == 1 ]]; then
      mkdir C++
      cd C++
      mkdir src
      cd src && touch main.cpp
      cd ..
      createReadme
      createGitIgnore
  elif [[ checkedCplusMake == 1 ]]; then
      mkdir CplusMake
      cd CplusMake
      mkdir src
      cd src && touch main.c 
      cd ..
      createReadme
      createMakeFile
      createGitIgnore
  elif [[ checkedCppplusMake == 1 ]]; then
      mkdir C++plusMake
      cd C++plusMake
      mkdir src
      cd src && touch main.cpp 
      cd ..
      createReadme
      createMakeFile
      createGitIgnore
  elif [[ checkedCplusCmake == 1 ]]; then
      mkdir CplusCmake
      cd CplusCmake
      mkdir src
      cd src && touch main.c 
      cd ..
      createReadme
      createCMakeLists
      createGitIgnore
  elif [[ checkedCppplusCmake == 1 ]]; then
      mkdir C++plusCmake
      cd C++plusCmake
      mkdir src
      cd src && touch main.cpp 
      cd ..
      createReadme
      createCMakeLists
      createGitIgnore
  fi
  echo "finished templates"
}

checkGit() {
	if [ -d .git ]; then
		echo "Git repository exists"
		return 0
	else
		echo "Git repository does not exist"
		return 1
	fi
}

showDir() {
	echo "Current directory: $(pwd)"
}

checkDir() {
	if [ -d "$1" ]; then
		echo "Directory exists"
		return 0
	else
		echo "Directory does not exist"
		return 1
	fi
}

checkTemplate() {
	if [ -d ~code/cpp/startp/templates/pureC ]; then
		echo "Template exists"
		return 0
	else
		echo "Template does not exist"
		return 1
	fi
}

help() {
	while IFS= read -r line; do
		echo "$line"
	done <"$help"
}

version() {
	echo $version
}

config() {
	cd ~/.config && mkdir startp
	cd startp
	mkdir templates
}

create_command()
{
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
			local pathValid=$(checkDir)
			local templateValid=$(checkTemplate)

			if [ pathValid == 1 && templateValid == 1]; then
				cd "$path"
				echo "template pasted"
				git init
				git add README.md
				showDir
				echo "template pasted"
			else
				echo "path test = $pathValid"
				echo "template test = $templateValid"
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

if [[ "$1" == " " ]]; then
  "nothing insereted , showing help"
  help
elif [[ "$1" == "create" ]]; then
  "creating command "
	create_command
elif [[ "$1" == "template" ]]; then
  echo "creating template"
  createTemplates
elif [[ "$1" == "version" ]]; then
  echo "showing version"
	version
elif [[ "$1" == "help" ]]; then
  "showing help"
	help
else
  echo "nothing selected"
fi

echo "startp | for starting C / Cpp projects | version : $version"

case "$OSTYPE" in
darwin*) echo "OSX" ;;
linux*) echo "LINUX" ;;
msys*) echo "WINDOWS" ;;
cygwin*) echo "CYGWIN" ;;
bsd*) echo "BSD" ;;
solaris*) echo "SOLARIS" ;;
*) echo "unknown: $OSTYPE" ;;
esac

