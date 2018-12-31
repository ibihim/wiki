#!/bin/bash
#
# Script that shows how here documents can be used
# in order to send a couple of commands to a server.
#
# Usage ./02-07-b-here-docs.sh 192.178.0.10

ssh $1 <<EOF
ls
dokcer container run --rm hello-world
nmap nsa.gov
EOF
