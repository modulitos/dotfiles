{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs;
    [
      # use signal-desktop within a non-nixos home manager install:
      signal-desktop
    ];
}
