{pkgs, ...}: {
  environment.systemPackages = [
    (import ./scripts/vos.nix {inherit pkgs;})
  ];
}
