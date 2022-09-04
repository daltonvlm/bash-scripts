#!/bin/bash

#
# Set the scripts for use.
#  
# Author: Dalton Martins - daltonvlm (daltonvlm@gmail.com)
# Since: 2022-08-31
#

function help() {
    echo "Set the scripts for use."

    echo ""
    echo "Usage: $prog"
    echo "Or: '$prog -h' to print this help."
    echo ""
    exit $1
}

function main() {
    test "$help" = -h && help

    local bin=~/bin

    mkdir -p "$bin"
    for f in `ls -I "$prog" -Idefault.sh -I*[^.sh]`
    do
        chmod +x "$f" && ln -sf ${PWD}/"$f" "$bin"
    done
}

prog=`basename "$0"`
help="$1"

main
