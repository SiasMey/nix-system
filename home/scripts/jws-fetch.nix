{pkgs}:
pkgs.writeShellScriptBin "jws-fetch" ''
  set -e

  jj git fetch
  jj rebase -d 'trunk()'

  cd "$(jj workspace root)/../.clone"
  jj rebase -d 'trunk()'
''
