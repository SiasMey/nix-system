{pkgs}:
pkgs.writeShellScriptBin "ts" ''
  if [ -z "$TMUX" ];
  then
    tmux-sessionizer
  else
    tmux display-popup -E tmux-sessionizer
  fi
''
