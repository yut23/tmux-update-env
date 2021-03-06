if [[ -n $TMUX ]]; then
  0="${${ZERO:-${0:#$ZSH_ARGZERO}}:-${(%):-%N}}"
  0="${${(M)0:#/*}:-$PWD/$0}"
  _tmux_update_env_path="$(tmux display-message -p "$("${0:h}/scripts/get_env_path.sh")")"

  _tmux_update_env_last_change=$(date +%s)
  function _update_tmux_env() {
    if [[ -e "$_tmux_update_env_path" ]] && \
       (( $(<"$_tmux_update_env_path") > $_tmux_update_env_last_change )); then
      # don't clear DISPLAY or XAUTHORITY
      eval "$(tmux show-environment -s | grep -vE '^unset (DISPLAY|XAUTHORITY);$')"
      _tmux_update_env_last_change=$(<"$_tmux_update_env_path")
    fi
  }

  autoload -Uz add-zsh-hook
  add-zsh-hook preexec _update_tmux_env
fi
