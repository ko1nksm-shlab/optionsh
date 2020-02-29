#!/bin/sh

. ./common.sh

# --------------------------------------------------------------------
FLAG_A='' FLAG_B='' ARG_I='' ARG_J='' OPT_O='' OPT_P='' PARAMS=''

push_end() { [ "${2#*\'}" = "$2" ] && eval "$1=\"\$$1 '\${3:-}\$2'\""; }
push() { push_end "$@" || push "$1" "${2#*\'}" "${2%%\'*}'\"'\"'"; }

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
      -i | --arg-i ) required "$@" && shift; push ARG_I "$1" ;;
      -j | --arg-j ) required "$@" && shift; push ARG_J "$1" ;;
      -o | --opt-o ) optional "$@" && shift; push OPT_O "${OPTARG:-1}" ;;
      -p | --opt-p ) optional "$@" && shift; push OPT_P "${OPTARG:-default}" ;;
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
HERE

arg_i() { if [ $# -gt 0 ]; then printf 'ARG_I: %s\n' "$@"; fi; }
arg_j() { if [ $# -gt 0 ]; then printf 'ARG_J: %s\n' "$@"; fi; }
opt_o() { if [ $# -gt 0 ]; then printf 'OPT_O: %s\n' "$@"; fi; }
opt_p() { if [ $# -gt 0 ]; then printf 'OPT_P: %s\n' "$@"; fi; }
eval arg_i "$ARG_I"
eval arg_j "$ARG_J"
eval opt_o "$OPT_O"
eval opt_p "$OPT_P"

i=0
for p; do
  i=$((i + 1))
  echo "\$$i: $p"
done
