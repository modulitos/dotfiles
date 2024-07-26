{
  description = "flake for oolong";

  inputs = {
    nixpkgs = { url = "github:NixOS/nixpkgs/nixos-unstable"; };
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, darwin }:
    let importPkgs = (system: import nixpkgs { inherit system; });
    in {
      homeConfigurations = {
        "lucas@grease-lightning" = home-manager.lib.homeManagerConfiguration {
          pkgs = importPkgs "x86_64-linux";
          modules = [ ./home/archlinux.nix ];
        };

        "lswart@black" = home-manager.lib.homeManagerConfiguration {
          pkgs = importPkgs "x86_64-linux";

          extraSpecialArgs =
            {
              username = "lswart";
            };
          modules = [
            ./home/common.nix
	  ];
        };
        # TODO: set up macbook:
        # "lucas@my-macbook" = home-manager.lib.homeManagerConfiguration {
        #   pkgs = importPkgs "aarch64-darwin";

        #   modules = [
        #     ./home/common.nix
        #   ];
        # };
      };
      nixosConfigurations = {
        oolong = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./configuration.nix
            ./oolong-hardware-configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.lucas = import ./home/nixos.nix;
              home-manager.extraSpecialArgs = { username = "lucas"; };
            }
          ];
        };
        puerh = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./configuration.nix
            ./puerh-hardware-configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.lswart = import ./home/nixos.nix;
              home-manager.extraSpecialArgs = { username = "lswart"; };
            }
          ];
        };
      };
      darwinConfigurations = {
        # http://daiderd.com/nix-darwin/#flakes
        # https://nix-community.github.io/home-manager/index.xhtml#sec-flakes-nix-darwin-module
        "earlygrey" = darwin.lib.darwinSystem {
          system = "x86_64-darwin";
          # Declaritvely configure MacOS options:
          # https://daiderd.com/nix-darwin/manual/index.html
          modules = [
            ./darwin-configuration.nix
            home-manager.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.lswart = import ./home/common.nix;

              home-manager.extraSpecialArgs = { username = "lswart"; };
            }
          ];
        };
      };
    };
}
