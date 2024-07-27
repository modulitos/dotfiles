{ pkgs, ... }: {
  # FIXME: Uncomment this if you want the Fish config on your Macbook
  # imports = [
  #   ./fish.nix
  # ];

  # TODO: If you really want to, you can declaratively configure most of your macOS options
  # https://daiderd.com/nix-darwin/manual/index.html

  # users.users.${username}.home = "/Users/${username}";
  users.users.lswart.home = "/Users/lswart";
  services.nix-daemon.enable = true;

  nix = {
    nixPath = [
      { darwin-config = "$HOME/.config/nixpkgs/darwin-configuration.nix"; }
      "/nix/var/nix/profiles/per-user/root/channels"
    ];
    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
    };
  };
}
