{pkgs}:
pkgs.writeShellScriptBin "jws-clean" ''
  set -e

  cd $PROJECT_DIR/.clone
  fd -IH .jj $PROJECT_DIR -E .clone -d 2 | cut -d '/' -f 2 | xargs -I _ echo "jj workspace forget _"
  cd $PROJECT_DIR
  fd -IH .jj -E .clone -d 2 | cut -d '/' -f 1 | xargs echo
''
