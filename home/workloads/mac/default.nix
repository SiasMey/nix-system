{ pkgs, ... }:
{
  imports = [
    ./mac.nix
  ];
  home.packages = [
    (import ./focus-or-start.nix { inherit pkgs; })
  ];
}
