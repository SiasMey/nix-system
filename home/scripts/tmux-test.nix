{ pkgs }:
pkgs.writeShellScriptBin "tmux-test" ''
  tmux send-keys -t right "$TEST_CMD" Enter
''
