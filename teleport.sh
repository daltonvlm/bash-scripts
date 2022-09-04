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
    test ! "$file" && help 1
    test "$file" = -h && help
    test ! -e "$path" && >&2 printf "Path '%s' not found.\n" "$path" && exit 1
    test ! -d "$path" && >&2 printf "'%s' is not a directory.\n" "$path" && exit 1

    local dirs=
    local dir=

    dirs=`find "$path" -type f -iname "$file" -exec dirname {} \; 2>/dev/null`

    test ! "$dirs" && 2>1 echo "No directories found." && exit 1

    echo -e "Found:\n$dirs"

    dir=`echo "$dirs" | tr "\n" : | cut -d: -f1`

    test "$dir" && cd "$dir" && \
        printf "Changed directory to '%s'.\n" "$dir" ||\
        >&2 printf "Couldn't enter in '%s'.\n" "$dir"
}

# Must be fixed since it will be called by this way: '. teleport ...'
prog=teleport
file="$1"
path="${2:-.}"

main
