#!/bin/bash

usage() {
cat<<EOF
Usage: `basename $0` [-h]

This script displays summary of a project.

Options:

    -h  Show this message

EOF
}

while getopts “hs” OPTION
do
    case $OPTION in
        h)
            usage
            exit 1
            ;;
    esac
done
