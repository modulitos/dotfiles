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
    calibre
    # for "notify-send" command to make desktop notifications:
    libnotify
    # for the "play" command to play audio:
    sox

    transmission_4
    vlc
    steam
    vulkan-tools
  ];
  # # TODO: this is overridden by configuration.nix?
  # nixpkgs.config.allowUnfreePredicate = pkg:
  #   builtins.elem (lib.getName pkg) [ "spotify" "slack" "steam-unwrapped" ];

}
