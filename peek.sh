#!/bin/bash

usage() {
cat<<EOF
Usage: `basename $0` [options]

This script displays summary of a project.

Options:

    -h --help  Show this message

EOF
}

while getopts ":hl" opt
do  case "$opt" in
        h)  usage
            exit 0;;
        l)  LONG=true
            ;;
        ?)  usage
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

short_peek() {
cat<<EOF
${bold}$NAME${normal} (${DIR/$HOME/~})
    $DESC
EOF
}

long_peek() {
cat<<EOF
${bold}$NAME${normal} (${DIR/$HOME/~})
    $DESC
EOF
}

for dir in $DIRS
do
    DIR=`cd $dir; pwd`
    README=`ls $DIR | grep -i -m 1 "readme.*"`
    HEADER=`grep -m 1 "^# .*:" $DIR/$README`; HEADER=${HEADER#\# }
    NAME=${HEADER%:*}
    DESC=${HEADER#*:}
    if $LONG
    then
        short_peek
    else
        long_peek
    fi
done

