{
  pkgs,
  ...
}: {
  users.users.lswart.home = "/Users/lswart";
  services.nix-daemon.enable = true;

  nix = {
    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
    };
  };
}
