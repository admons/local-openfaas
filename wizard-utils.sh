#!/bin/bash

BLU='\033[1;34m'
MGT='\033[1;95m'
END='\033[0m'
BLOCK='\033[1;37m'

PATH=/usr/local/bin:$PATH
export PATH

# wait for Enter key to be pressed
function pause(){
  read -rp "[Enter] Continue..."
}

# show info text and command, wait for enter, then execute and print a newline
function info_pause_exec() {
  step "$1"
  read -rp $'\033[1;37m#\033[0m'" Command: "$'\033[1;96m'"$2"$'\033[0m'" [Enter]"
  echo ""
  exe $2
  echo ""
}

# show command and execute it
exe() { echo "\$ ${@/eval/}" ; eval $@ ; } 

# highlight a new section
section() {
  echo ""
  log "***** Section: ${MGT}$1${END} *****"; 
  echo ""
}

# highlight the next step
step() { 
  echo ""
  echo ""
  echo ""
  log "Step: ${BLU}$1${END}"; 
  echo ""
}

# output a "log" line with bold leading >>>
log() { >&2 printf "${BLOCK}#${END} $1\n"; }
