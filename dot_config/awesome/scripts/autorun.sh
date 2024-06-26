#!/usr/bin/env bash

set -euo pipefail

run() {
  if ! pgrep -f "$1" ;
  then
    "$@"&
  fi
}

current_dir="$(dirname "$0")"

source "$current_dir/xrandr.sh"
