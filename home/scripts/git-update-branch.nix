{pkgs}:
pkgs.writeShellScriptBin "git-update-branch" ''
  set -e
  main=$(git remote show origin | awk '/HEAD branch/ {print $NF}')

  git fetch origin "$main" && git merge "origin/$main"
''
