#!/bin/bash

#
# Change directory to the first directory containing a file with the given 
# name from the given path. Search is made ignoring case.
#  
# Parameters:
# <file>: File name.
# [path]: Path from which the search is made. Default value is '.'.
#
# Author: Dalton Martins - daltonvlm (daltonvlm@gmail.com)
# Since: 2022-08-31
#

# Must be fixed since it will be called by this way: '. teleport ...'
prog=teleport
file=$1
path=${2:-.}

function help() {
    echo "Change directory to the first directory containing a file with the given name from the given path. Search is made ignoring case."
    echo ""
    echo "Usage: . $prog <file> [path]"
    echo "Or: '$prog -h' to print this help."
    echo ""
    echo "File: File name."
    echo "Path: Path from which the search is made. Default value is '.'."
    exit $1
}

function main() {
    test "$file" = -h && help
    test ! $file && help 1

    local dirs=`find "$path" -type f -iname "$file" \
        -exec dirname {} \; 2>/dev/null`

    test $dirs && echo -e "Found:\n$dirs"

    local dir=`echo "$dirs" | tr "\n" : | cut -d: -f1`

    test $dir && cd $dir && \
        echo Changed directory to $dir. ||\
        echo "Directory not found."
}

main
