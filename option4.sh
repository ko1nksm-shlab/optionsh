#!/bin/sh

. ./common.sh

# --------------------------------------------------------------------
FLAG_A='' FLAG_B='' ARG_I='' ARG_J='' PARAMS=''

parse_options() {
  OPTIND=$(($# + 1))
  while [ $# -gt 0 ]; do
    case $1 in
      -a | --flag-a) FLAG_A=1 ;;
      -b | --flag-b) FLAG_B=1 ;;
      -i | --arg-i ) required "$@" && shift; ARG_I=$1 ;;
      -j | --arg-j ) required "$@" && shift; ARG_J=$1 ;;
      --) shift; params PARAMS $((OPTIND - $#)) $OPTIND; break ;;
      -?*) unknown "$@" ;;
      *) param PARAMS $((OPTIND - $#))
    esac
    shift
  done
}

parse_options "$@"
eval "set -- $PARAMS"
# --------------------------------------------------------------------

cat<<HERE
FLAG_A: $FLAG_A
FLAG_B: $FLAG_B
ARG_I: $ARG_I
ARG_J: $ARG_J
HERE
i=0
for p; do
  i=$((i + 1))
  echo "\$$i: $p"
done
