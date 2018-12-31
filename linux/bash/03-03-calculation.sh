#!/bin/bash
#
# $1 is the first number
# $2 is the operator
# $3 is the second number

echo $1 $2 $3

echo $(( $1 $2 $3 ))
let x="$1 $2 $3"
echo $x
echo "scale=9; $1 $2 $3" | bc

