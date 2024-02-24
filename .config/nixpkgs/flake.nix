{
  description = "flake for oolong";

  inputs = {
    nixpkgs = { url = "github:NixOS/nixpkgs/nixos-unstable"; };
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager }:
    let
      system = "x86_64-linux";
      nonfreepkgs = import "${nixpkgs}" {
        inherit system;
        config.allowUnfree = true;
      };
      importPkgs = (system:
        import nixpkgs {
          inherit system;
          # overlays = [ deploy_rs_overlay hush_overlay ];
        });
      # pkgs = import "${nixpkgs}" {
      #   inherit system;
      #   # this is atypical - but allows defining the source of all packages in
      #   # one place.
      #   #
      #   # overlays = [ (final: prev:{
      #   #     # if pkgs already has slack, it gets replaced with slack below:
      #   #     slack = nonfreepkgs.slack;
      #   #     sublime4 = nonfreepkgs.sublime4;
      #   #     spotify = nonfreepkgs.spotify;
      #   # }) ];
      # };
    in {
      homeConfigurations = {
        "lucas@grease-lightning" = home-manager.lib.homeManagerConfiguration {
          pkgs = importPkgs "x86_64-linux";
          modules = [ ./home ./home/linux ];
        };

        # TODO: set up macbook:
        # "lucas@my-macbook" = home-manager.lib.homeManagerConfiguration {
        #   pkgs = importPkgs "aarch64-darwin";

        #   modules = [ ./home ./home/darwin ];
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
              home-manager.users.lucas = import ./home;
            }
            # this doesn't work:
            ./home/linux
          ];
        };
      };
    };
}
