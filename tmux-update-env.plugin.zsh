if [[ -n $TMUX ]]; then
  0="${${ZERO:-${0:#$ZSH_ARGZERO}}:-${(%):-%N}}"
  0="${${(M)0:#/*}:-$PWD/$0}"
  _tmux_update_env_path="$(tmux display-message -p "$("${0:h}/scripts/get_env_path.sh")")"

  _tmux_update_env_last_change=$(date +%s)
  function _update_tmux_env() {
    if [[ -e "$_tmux_update_env_path" ]] && \
       (( $(<"$_tmux_update_env_path") > $_tmux_update_env_last_change )); then
      lines=("${(@f)$(tmux show-environment -s)}")
      # if DISPLAY is unset in the current session (i.e. no X forwarding),
      # don't change DISPLAY or XAUTHORITY, so programs will run on the remote
      # display instead (only on mandelbrot)
      if (( ${lines[(I)unset DISPLAY;]} )) && [[ $system_name == mandelbrot ]]; then
        # remove the matching elements
        lines=("${(@)lines:#unset (DISPLAY|XAUTHORITY);}")
      fi
      # this expands to a single string, joining the array elements
      eval "${lines}"
      _tmux_update_env_last_change=$(<"$_tmux_update_env_path")
    fi
  }

  autoload -Uz add-zsh-hook
  add-zsh-hook preexec _update_tmux_env
fi
