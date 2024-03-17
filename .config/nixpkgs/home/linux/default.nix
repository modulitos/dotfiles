{ config, lib, pkgs, ... }:
let
  gdk = pkgs.google-cloud-sdk.withExtraComponents
    (with pkgs.google-cloud-sdk.components; [ gke-gcloud-auth-plugin ]);
in {
  home.packages = with pkgs; [
    signal-desktop
    dunst
    kanshi
    slack
    spotify
    chromium
    swayrbar
    grim
    slurp
    ripgrep
    gdk
    # for "notify-send" command to make desktop notifications:
    libnotify
    # for the "play" command to play audio:
    sox
  ];
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [ "spotify" "slack" ];

}
