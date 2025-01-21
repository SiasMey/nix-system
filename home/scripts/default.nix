{pkgs, ...}: {
  home.packages = [
    (import ./vhm.nix {inherit pkgs;})
    (import ./vss.nix {inherit pkgs;})
    (import ./vv.nix {inherit pkgs;})
    (import ./vt.nix {inherit pkgs;})
    (import ./vm.nix {inherit pkgs;})
    (import ./palette.nix {inherit pkgs;})
    (import ./gwt-clone.nix {inherit pkgs;})
    (import ./git-update-branch.nix {inherit pkgs;})
  ];
}
