#!/bin/bash
#
# Shows command substitution by creating a current date file:
echo "executing \"touch $(mktemp -d)/file-$(date +%d-%m-%y)\""
touch "$(mktemp -d)/file-$(date +%d-%m-%y)"

