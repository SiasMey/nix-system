{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.darwin.follows = "";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    agenix,
    ...
  } @ inputs: let
    inherit (self) outputs;
  in {
    nixosConfigurations = {
      foot1 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [./host/foot1];
      };
      foot2 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./host/foot2
          agenix.nixosModules.default
        ];
      };
      foot3 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./host/foot3
          agenix.nixosModules.default
        ];
      };
    };

    homeConfigurations = {
      "meysi@HPE-LFL6NJ14KD" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.aarch64-darwin;
        extraSpecialArgs = {inherit inputs outputs;};
        modules = [
          ./home/users/meysi/work-laptop.nix
          {
            home.username = "meysi";
            home.homeDirectory = "/Users/meysi";
            # Allow unfree packages
            nixpkgs.config.allowUnfree = true;
          }
        ];
      };

      "siasm@foot3" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {inherit inputs outputs;};
        modules = [
          ./home/users/siasm/foot3.nix
          {
            home.username = "siasm";
            home.homeDirectory = "/home/siasm";
          }
        ];
      };

      "siasm@foot2" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {inherit inputs outputs;};
        modules = [
          ./home/users/meysi/foot2.nix
          {
            home.username = "siasm";
            home.homeDirectory = "/home/siasm";
          }
        ];
      };
    };
  };
}
