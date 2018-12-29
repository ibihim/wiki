#!/bin/bash
#
# Sppcript that shows how here documents can be used
# as an alternative to the echo command.

cat <<EOF
------------------------------------
This is line 1 of the message
This is line 2 of the message
This is the last line of the message
-------------------------------------
EOF
