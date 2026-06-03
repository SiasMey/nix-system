{pkgs}:
pkgs.writeShellScript "jws-prv" ''
  set -e
  gh pr view $WS_BOOKMARK $0
''
