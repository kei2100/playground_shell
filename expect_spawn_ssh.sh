#!/bin/bash

USER=$1
HOST=$2
PASSWORD=$3

# simple
expect <<EOF
set timeout 10
spawn ssh ${USER}@${HOST}
expect password: ; send "${PASSWORD}\r"
expect "$ " ; send "hostname\r"
expect "$ " ; send "exit\r"
EOF

# functions
EXPECT_SSH_CMD() {
expect <<EOF
  set timeout -1
  spawn ssh ${SSH_USER}@${HOST}
  expect "password:" {
    send "${PASSWORD}\r" 
    expect "$ " {
      send "${1}\r"
      expect "$ " ; send "exit\r"
    } "Permission denied, please try again." {
      puts "(ERROR) Failed to login."
      exit 1
    }
  } timeout {
    puts "(ERROR) Failed to connect."
    exit 1
  }
EOF
}

EXPECT_SCP_PULL() {
expect <<EOF
  set timeout -1
  spawn scp ${SSH_USER}@${HOST}:${1} ${2}
  expect "password:" {
    send "${PASSWORD}\r" 
    expect "$ " {
      puts "done"
    } "Permission denied, please try again." {
      puts "(ERROR) Failed to login."
      exit 1
    }
  } timeout {
    puts "(ERROR) Failed to connect."
    exit 1
  }
EOF
}

