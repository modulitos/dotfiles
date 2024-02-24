{
  description = "flake for oolong";

  inputs = {
    nixpkgs = { url = "github:NixOS/nixpkgs/nixos-unstable"; };
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager }:
    let importPkgs = (system: import nixpkgs { inherit system; });
    in {
      homeConfigurations = {
        "lucas@grease-lightning" = home-manager.lib.homeManagerConfiguration {
          pkgs = importPkgs "x86_64-linux";
          modules = [ ./home/archlinux.nix ];
        };

        # TODO: set up macbook:
        # "lucas@my-macbook" = home-manager.lib.homeManagerConfiguration {
        #   pkgs = importPkgs "aarch64-darwin";

        #   modules = [ ./home/macos.nix ];
        # };
      };
      nixosConfigurations = {
        oolong = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.lucas = import ./home/nixos.nix;
            }
          ];
        };
      };
    };
}
