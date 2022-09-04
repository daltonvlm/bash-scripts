#!/bin/bash

#
# Copy file to clipboard.
#  
# Parameters:
# <file>: File to copy.
#
# Author: Dalton Martins - daltonvlm (daltonvlm@gmail.com)
# Since: 2022-08-31
#

function help() {
    echo "Copy file to clipboard."
    echo ""
    echo "Usage: $prog <file>"
    echo "Or: '$prog -h' to print this help."
    echo ""
    echo "File: file to copy to clipboard."
    exit $1
}

function main() {
    test ! "$file" && help 1
    test "$file" = -h && help
    test ! -f "$file" && >&2 echo "File not found." && exit 1
    cat "$file" | xclip -selection clipboard
}

prog=`basename "$0"`
file="$1"

main
