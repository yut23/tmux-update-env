#!/usr/bin/env bash
set -euo pipefail

# include hostname for systems with shared home
default_env_dir="$HOME/.tmux/update-env/#{host}"
env_dir_option="@update-env-dir"

default_env_filename="#{?session_grouped,group_#{session_group},session_#{session_name}}.sh"
env_filename_option="@update-env-filename"

get_tmux_option() {
  local option="$1"
  local default_value="$2"
  local option_value
  option_value="$(tmux show-option -gqv "$option")"
  if [ -z "$option_value" ]; then
    echo "$default_value"
  else
    echo "$option_value"
  fi
}

env_dir="$(get_tmux_option "$env_dir_option" "$default_env_dir" | sed "s,\$HOME,$HOME,g; s,\~,$HOME,g")"

echo "${env_dir}/$(get_tmux_option "$env_filename_option" "$default_env_filename")"
