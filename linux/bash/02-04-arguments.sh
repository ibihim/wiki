#!/bin/bash
#
# Script with arguments.

echo "\$0: $0"
echo "\$1: $1"
echo "\$2: $2"
echo "All args as an 'array of strings': $@"
echo "All args as one string: $*"
echo "Amount of args: $#"
echo "\$1: $1"
echo "shift"
shift
echo "\$1: $1"

