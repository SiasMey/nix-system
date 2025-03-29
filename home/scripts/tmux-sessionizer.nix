{pkgs}:
pkgs.writeShellScriptBin "tmux-sessionizer" ''
    if [[ $# -eq 1 ]]; then
      selected=$1
  else
      items="$(echo $HOME/nix-system)\n"
      items+="\n$(find ~/work -maxdepth 1 -mindepth 1 -type d)"
      items+="\n$(find ~/personal -maxdepth 1 -mindepth 1 -type d)"
      selected=$(echo -e "$items" | fzf --reverse)
  fi

  if [[ $? -gt 0 ]]; then
      exit 0
  fi

  tmux_session_name=$(basename $selected | tr . _)

  tmux switch-client -t $tmux_session_name
  if [[ $? -eq 0 ]]; then
      exit 0
  fi

  tmux new-session -c $selected -d -s $tmux_session_name && tmux switch-client -t $tmux_session_name || tmux new -c $selected -A -s $tmux_session_name
''
