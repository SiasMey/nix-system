{pkgs}:
pkgs.writeShellScriptBin "jws-clone" ''
  set -e

  url=$1
  basename=''${url##*/}
  repo_name=''${2:-''${basename%.*}}

  mkdir "$repo_name"
  cd "$repo_name"

  jj git clone $url .clone
  echo 'export CLONE_DIR="$(pwd)/.clone"' >> ".envrc"
  echo 'export GIT_DIR="$CLONE_DIR/.jj/repo/store/git"' >> ".envrc"
  echo 'export PROJECT_DIR="$(pwd)"' >> ".envrc"
  direnv allow
''
