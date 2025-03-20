{pkgs}:
pkgs.writeShellScriptBin "vos" ''
  set -e

  cd ~/Dotfiles/system
  nvim configuration.nix
  git add .
  temp_file=$(mktemp)
  echo "chore: update nixos config" >> $temp_file
  echo "" >> $temp_file
  echo "$(nixos-rebuild list-generations | head -n 2)" >> $temp_file
  echo "" >> $temp_file
  echo "from: $(uname -no)" >> $temp_file

  git commit -F $temp_file
  rm $temp_file

  nh os build ~/Dotfiles/system
  nh os switch ~/Dotfiles/system

  git push
''
