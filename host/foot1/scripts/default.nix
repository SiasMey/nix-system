{pkgs, ...}: {
  environment.systemPackages = [
    (import ./vos.nix {inherit pkgs;})
  ];
}
