{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: {
    nixosConfigurations = {
      foot1 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [./host/foot1];
      };
    };
  };
}
