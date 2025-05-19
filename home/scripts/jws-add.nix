{pkgs}:
pkgs.writeShellScriptBin "jws-add" ''
  set -e

  TYPE=$1
  NAME=$2

  jj workspace add -R "$CLONE_DIR" "$PROJECT_DIR/$NAME"
  cd "$PROJECT_DIR/$NAME"
  echo "export WS_BOOKMARK=sm/$TYPE/$NAME" >> .envrc
  echo "source_up" >> .envrc
  direnv allow
''
