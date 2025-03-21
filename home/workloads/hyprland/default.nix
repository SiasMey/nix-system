{pkgs, ...}: {
  imports = [
    ./hyprland.nix
  ];
  home.packages = [
    (import ./focus-or-start.nix {inherit pkgs;})
  ];
}
