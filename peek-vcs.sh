#!/bin/bash

# This script detect mayor version control systems.

# Parse user input
if [ -z $@ ]
then
    DIR=`pwd`
else
    DIR=${1%/}
fi

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
