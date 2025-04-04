{ pkgs }:
pkgs.writeShellScriptBin "tmux-cd-pwd" ''
  tmux send-keys -t right "cd $(pwd)" "Enter"
''
