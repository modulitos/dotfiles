  {
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      nonfreepkgs = import "${nixpkgs}" {
        inherit system;
        config.allowUnfree = true;
      };
      pkgs = import "${nixpkgs}" {
        inherit system;
        # this is atypical - but allows defining the source of all packages in
        # one place.
        #
        # overlays = [ (final: prev:{
        #     # if pkgs already has slack, it gets replaced with slack below:
        #     slack = nonfreepkgs.slack;
        #     sublime4 = nonfreepkgs.sublime4;
        #     spotify = nonfreepkgs.spotify;
        # }) ];
      };

    in {
      homeConfigurations.lucas = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home.nix
        ];
      };
    };
}
