#!/bin/bash

# Parse user input
if [ -n $@ ]
then
    DIR=`pwd`
else
    DIR=$1
fi

# Remove the last slash
DIR=${DIR%/}

# Detect version control system
if [ -e "$DIR/.bzr" ]; then
    echo "bzr"
elif [ -e "$DIR/.git" ]; then
    echo "git"
elif [ -e "$DIR/.hg" ]; then
    echo "hg"
else
    echo "?"
fi
