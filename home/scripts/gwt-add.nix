{ pkgs }:
pkgs.writeShellScriptBin "gwt-add" ''
  set -e

  TYPE=$1
  NAME=$2

  GITROOT=$(git rev-parse --path-format=absolute --git-common-dir | sed 's:/.bare::')
  cd "$GITROOT" || exit

  git worktree add -b "sm/$TYPE/$NAME" "$NAME"
''
