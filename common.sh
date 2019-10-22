#!/bin/sh

set -e

abort() { echo "$*" >&2; exit 1; }
unknown() { abort "unrecognized option '$1'"; }
required() { [ $# -gt 1 ] || abort "option '$1' requires an argument"; }
param() { eval "$1=\$$1\ \\\"\"\\\${$2}\"\\\""; }
params() { [ "$2" -ge "$3" ] || params_ "$@"; }
params_() { param "$1" "$2"; params "$1" $(($2 + 1)) "$3"; }
noarg() { [ ! "$OPTARG" ] || abort "option '$1' doesn't allow an argument"; }
optional() { [ "$OPTARG" ] && OPTARG=$2; }
