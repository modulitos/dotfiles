{
  description = "flake for oolong";

  inputs = {
    nixpkgs = { url = "github:NixOS/nixpkgs/nixos-unstable"; };
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  # helpful:
  # https://github.com/chrisportela/dotfiles/blob/main/flake.nix
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
        # error: flake 'path:/home/lucas/.config/nixpkgs' does not provide attribute 'apps.x86_64-linux.default', 'defaultApp.x86_64-linux', 'packages.x86_64-linux.default' or 'defaultPackage.x86_64-linux'
        "lucas@grease-lightning" = home-manager.lib.homeManagerConfiguration {
          # inherit pkgs;
          pkgs = importPkgs "x86_64-linux";
          modules = [ ./home.nix ];
        };
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
              home-manager.users.lucas = import ./home.nix;
            }
          ];
        };
      };
    };
}
