#!/bin/bash


# Get path of this script
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ] ; do SOURCE="$(readlink "$SOURCE")"; done
BIN="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

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
${bold}$NAME${normal}: $DESC (${DIR/$HOME/~}) [$VCS]
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
    if [ -z "$HEADER" ]
    then
        NAME=`basename $DIR`
        DESC=""
    else
        NAME=${HEADER%:*}
        DESC=${HEADER#*: *}
    fi
    VCS=`$BIN/peek-vcs.sh $DIR`

    if $LONG
    then
        short_peek
    else
        long_peek
    fi
done

