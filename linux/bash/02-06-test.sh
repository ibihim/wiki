#!/bin/bash
#
# Exits with error code 1/2/3 if no variable is given for $1/$2/$3.
[ -z $1 ] && exit 1

test -z $2 && exit 2

[ $3 ] || exit 3

# As last command did not result with $0, but it is expected behavior.
exit 0

