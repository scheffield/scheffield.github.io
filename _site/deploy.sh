#!/usr/bin/env bash

set -Eeuo pipefail
trap cleanup SIGINT SIGTERM ERR EXIT

DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P)

# from https://stackoverflow.com/a/34676160/504356
WORK_DIR=`mktemp -d`

cleanup() {
  trap - SIGINT SIGTERM ERR EXIT
  # script cleanup here
  rm -rf "$WORK_DIR"
  msg "Deleted temp working directory $WORK_DIR"
}

msg() {
  echo >&2 -e "${1-}"
}

die() {
  local msg=$1
  local code=${2-1} # default exit status 1
  msg "$msg"
  exit "$code"
}

main() {
  jekyll build
  git clone  --depth 1 git@github.com:scheffield/scheffield.github.io.git "${WORK_DIR}"
  rsync -av "${DIR}/_site" "${WORK_DIR}"
  pushd "${WORK_DIR}"
  git add -A
  git commit -m "."
  git push
  popd
}

main "$@"
