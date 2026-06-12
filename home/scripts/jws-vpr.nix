{pkgs}:
pkgs.writeShellScriptBin "jws-vpr" ''
  set -e
  gh pr view $WS_BOOKMARK $0
''
