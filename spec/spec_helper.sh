#shellcheck shell=sh

# set -eu

shellspec_spec_helper_configure() {
  shell() {
    if [ "$SHELLSPEC_KCOV" ]; then
      export BASH_ENV=spec/kcov-helper.sh
    fi
    $SHELLSPEC_SHELL "$@"
  }
}
