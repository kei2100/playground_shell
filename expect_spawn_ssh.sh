#!/bin/bash

USER=$1
HOST=$2
PASSWORD=$3

expect <<EOF
set timeout 10
spawn ssh ${USER}@${HOST}
expect password: ; send "${PASSWORD}\r"
expect "$ " ; send "hostname\r"
expect "$ " ; send "exit\r"
EOF
