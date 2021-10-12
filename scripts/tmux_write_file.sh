#!/usr/bin/env bash
set -euo pipefail

env_file="$1"
mkdir -p "$(dirname "$env_file")"
date +%s > "$env_file"
