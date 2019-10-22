#!/bin/sh

. ./common.sh

# --------------------------------------------------------------------
FLAG_A='' FLAG_B=''

for arg; do
  case $arg in
    -a | --flag-a) FLAG_A=1 ;;
    -b | --flag-b) FLAG_B=1 ;;
    -?*) unknown "$@" ;;
    *) set -- "$@" "$arg"
  esac
  shift
done
# --------------------------------------------------------------------

cat<<HERE
FLAG_A: $FLAG_A
FLAG_B: $FLAG_B
HERE
i=0
for p; do
  i=$((i + 1))
  echo "\$$i: $p"
done
