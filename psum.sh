#!/bin/bash

usage() {
cat<<EOF
Usage: `basename $0` [options]

This script displays summary of a project.

Options:

    -h --help  Show this message

EOF
}

while getopts ":h" opt
do      case "$opt" in
        h)      usage
                exit 0;;
        ?)      usage
                exit 1;;
        esac
done

shift $(($OPTIND -1))

if [ -n ""$1"" ]
then
    DIRS="$@"
else
    DIRS=`ls -d */`
fi


bold=`tput bold`
normal=`tput sgr0`

for dir in $DIRS
do
    echo "${bold}${dir%/}:${normal}"

    head -n 3 "${dir}README.md"
done

