#!/bin/bash

#
# Open the first file found with the given name from the given path.
#  
# Parameters:
# <file>: File name.
# [path]: Path from which the search is made. Default value is '.'
#
# Author: Dalton Martins - daltonvlm (daltonvlm@gmail.com)
# Since: 2022-08-31
#

prog=`basename $0`
file=$1
path=${2:-.}

function help() {
    echo "Open the first file found with the given name from the given path."
    echo ""
    echo "Usage: $prog <file> [path]"
    echo "Or: '$prog -h' to print this help."
    echo ""
    echo "File: file name."
    echo "Path: path to search for the file. Default value is '.'."
    exit $1
}

function main() {
    test "$file" = -h && help
    test ! $file && help 1
    find "$path" -name "$file" -exec editor {} \; 
}

main
