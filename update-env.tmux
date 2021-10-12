#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# run-shell will expand any formats in $env_file
env_file="$("${CURRENT_DIR}/scripts/get_env_path.sh")"
tmux set-hook -g client-session-changed "run-shell \"$CURRENT_DIR/scripts/tmux_write_file.sh '$env_file'\""
