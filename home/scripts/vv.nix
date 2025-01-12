{pkgs}:
pkgs.writeShellScriptBin "vv" ''
  set -e

  cd ~/personal/NixHome/trunk/dotfiles/nix-nvim/lua

  nvim .
  git add .

  temp_file=$(mktemp)
  echo "chore: update neovim config" >> $temp_file
  echo "" >> $temp_file
  echo "" >> $temp_file
  echo "from: $(uname -no)" >> $temp_file
  echo "$(home-manager generations | head -n 1)" >> $temp_file

  git commit -F $temp_file
  rm $temp_file

  nh home build ~/personal/NixHome/trunk

  nh home switch ~/personal/NixHome/trunk

  git push
''
