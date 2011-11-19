#!/bin/bash


# Get path of this script
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ] ; do SOURCE="$(readlink "$SOURCE")"; done
BIN="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

# Usage message
usage() {
cat<<EOF
Usage: `basename $0` [options]

This script displays summary of a project.

Options:

    -h --help   Show this message
    -l --long   Force long output

EOF
}

# Parse cammand line arguments
while getopts ":hl" opt
do  case "$opt" in
        h)  usage
            exit 0;;
        l)  LONG=1
            ;;
        ?)  usage
            exit 1;;
    esac
done

shift $(($OPTIND -1))

if [ -n ""$1"" ]
then
    DIRS="$@"
    if [ $# -eq 1 ]; then
        LONG=1
    fi
else
    DIRS=`ls -d */`
fi

bold=`tput bold`
normal=`tput sgr0`

short_peek() {
cat<<EOF
${bold}$NAME${normal}: $SHORTDESC (${DIR/$HOME/~}) [$VCS]
EOF
}

long_peek() {
cat<<EOF
${bold}$NAME${normal}: $SHORTDESC (${DIR/$HOME/~}) [$VCS]
    $LONGDESC
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
        SHORTDESC=""
    else
        NAME=${HEADER%:*}
        SHORTDESC=${HEADER#*: *}
        LONGDESC=`grep -m 1 "^[A-Za-z]" $DIR/$README`
    fi
    VCS=`$BIN/peek-vcs.sh $DIR`

    if [ $LONG -eq 1 ]
    then
        long_peek
    else
        short_peek
    fi
done

