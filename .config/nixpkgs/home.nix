{ config, pkgs, ... }:

let
  tex = (pkgs.texlive.combine {
    inherit (pkgs.texlive)
      scheme-basic dvisvgm dvipng # for preview and export as html
      etoolbox titlesec enumitem preprint metafont charter # for org-mode resume
      wrapfig amsmath ulem hyperref capt-of;
    #(setq org-latex-compiler "lualatex")
    #(setq org-preview-latex-default-process 'dvisvgm)
  });
in {
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "lucas";
  home.homeDirectory = "/home/lucas";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.11";
  # home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # instead of in ~/.config/nix/conf.nix :
  # from: https://nixos.wiki/wiki/Flakes
  #
  # nix = {
  #   package = pkgs.nix;
  #   settings.experimental-features = [ "nix-command" "flakes" ];
  # };

  home.packages = with pkgs; [
    # vim
    # curl
    # zsh
    # git
    # slack
    # ripgrep
    # kubectl
    # kustomize
    # istioctl
    dyff
    jsonnet
    jsonnet-bundler
    postgresql
    # cloud-sql-proxy
    jq
    yq-go
    k6
    krew
    lsof
    socat
    delta
    httpie
    nurl
    pv
    nettools
    netcat
    kube3d
    docker-compose
    stern
    fzf
    tex
    htop
    fd
    dockfmt
    nixfmt
    shfmt
    tree
    starship
    git
    # rename
    # shellcheck
    # yamllint
    # go_1_18
    # sublime4
    # kubernetes-helm #Helm 3
    # pgcenter
    # keepass
    # ruby_2_7
  ];

  # home.activation = {
  #   linkDesktopApplications = {
  #     after = [ "writeBoundary" "createXdgUserDirectories" ];
  #     before = [ ];
  #     data = ''
  #       rm -rf ${config.xdg.dataHome}/"applications/home-manager"
  #       mkdir -p ${config.xdg.dataHome}/"applications/home-manager"
  #       cp -Lr ${config.home.homeDirectory}/.nix-profile/share/applications/* ${config.xdg.dataHome}/"applications/home-manager/"
  #     '';
  #   };
  # };
}
