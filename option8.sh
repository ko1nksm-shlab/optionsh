#!/bin/sh

. ./common.sh

# --------------------------------------------------------------------
FLAG_A='' FLAG_B='' ARG_I='' ARG_J='' OPT_O='' OPT_P='' PARAMS=''

parse_options() {
  OPTIND=$(($# + 1))
  while [ $# -gt 0 ] && OPTARG=; do
    case $1 in
      --?*=*) OPTARG=$1; shift
        set -- "${OPTARG%%\=*}" "${OPTARG#*\=}" "$@" ;;
      --no-*) unset OPTARG ;;
      -[ijop]?*) OPTARG=$1; shift
        set -- "${OPTARG%"${OPTARG#??}"}" "${OPTARG#??}" "$@" ;;
      -[!-]?*) OPTARG=$1; shift
        set -- "${OPTARG%"${OPTARG#??}"}" "-${OPTARG#??}" "$@"; OPTARG= ;;
      +??*) OPTARG=$1; shift
        set -- "${OPTARG%"${OPTARG#??}"}" "+${OPTARG#??}" "$@"; unset OPTARG ;;
      +*) unset OPTARG ;;
    esac

    case $1 in
      [-+]a | --flag-a | --no-flag-a) noarg "$@"; FLAG_A=${OPTARG+1} ;;
      [-+]b | --flag-b | --no-flag-b) noarg "$@"; FLAG_B=${OPTARG+1} ;;
      -i | --arg-i ) required "$@" && shift; ARG_I=$1 ;;
      -j | --arg-j ) required "$@" && shift; ARG_J=$1 ;;
      -o | --opt-o ) optional "$@" && shift; OPT_O=$OPTARG ;;
      -p | --opt-p ) optional "$@" && shift; OPT_P=$OPTARG ;;
      --) shift; params PARAMS $((OPTIND - $#)) $OPTIND; break ;;
      [-+]?*) unknown "$@" ;;
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
OPT_O: $OPT_O
OPT_P: $OPT_P
HERE
i=0
for p; do
  i=$((i + 1))
  echo "\$$i: $p"
done
