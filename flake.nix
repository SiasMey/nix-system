{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    ghostty = {
      url = "github:ghostty-org/ghostty";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    zen-browser,
    ghostty,
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
        modules = [./host/foot2];
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

      "meysi@foot1" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {inherit inputs outputs;};
        modules = [
          ./home/users/meysi/foot1.nix
          {
            home.packages = [
              inputs.zen-browser.packages.x86_64-linux.default
              inputs.ghostty.packages.x86_64-linux.default
            ];
            home.username = "meysi";
            home.homeDirectory = "/home/meysi";
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
