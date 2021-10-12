#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# run-shell will expand any formats
env_file="$("${CURRENT_DIR}/scripts/get_env_path.sh")"
mkdir -p "$(basename "$env_file")"
tmux set-hook -g client-session-changed run-shell "date +%s > '$env_file'"
