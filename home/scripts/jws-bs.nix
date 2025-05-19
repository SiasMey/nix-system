{pkgs}:
pkgs.writeShellScriptBin "jws-bs" ''
  set -e

  CURRENT_CHANGE=$(jj st --quiet | head -n 1)

  if [[ $CURRENT_CHANGE == "The working copy has no changes." ]]; then
    jj bookmark set $WS_BOOKMARK -r@-
  else
    jj bookmark set $WS_BOOKMARK -r@
  fi
  jj git push
''
