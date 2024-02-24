{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    signal-desktop
    dunst
    kanshi
    slack
    spotify
    chromium
    swaylock
    swayidle
    swayrbar
    grim
    slurp
    ripgrep
    # for "notify-send" command to make desktop notifications:
    libnotify
    # for the "play" command to play audio:
    sox
  ];
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [ "spotify" "slack" ];

}
