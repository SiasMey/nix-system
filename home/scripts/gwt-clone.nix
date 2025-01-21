{pkgs}:
pkgs.writeShellScriptBin "gwt-clone" ''
  set -e

  url=$1
  basename=\$\{url##*/\}
  repo_name=\$\{2:-\$\{basename%.*\}\}

  mkdir "$repo_name"
  cd "$repo_name"

  git clone --bare "$url" .bare
  echo "gitdir: ./.bare" > .git

  # Explicitly sets the remote origin fetch so we can fetch remote branches
  git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"

  # Gets all branches from origin
  git fetch origin

  default=$(git remote show origin | awk '/HEAD branch/ {print $NF}')

  git worktree add "$default" "$default"
''
