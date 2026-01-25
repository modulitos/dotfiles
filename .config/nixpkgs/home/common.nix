{ config, lib, username, pkgs, ... }:

let
  tex = (pkgs.texlive.combine {
    inherit (pkgs.texlive)
      koma-script pgf # for org-mode letters
      scheme-basic dvisvgm dvipng # for preview and export as html
      etoolbox titlesec enumitem preprint metafont charter # for org-mode resume
      wrapfig amsmath ulem hyperref capt-of;
    #(setq org-latex-compiler "lualatex")
    #(setq org-preview-latex-default-process 'dvisvgm)
  });
  # Until this issue is fixed: https://github.com/NixOS/nixpkgs/issues/305577
in {
  # # Home Manager needs a bit of information about you and the
  # # paths it should manage.
  # home.username = "lswart";
  # home.homeDirectory = "/home/lswart";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  # stateVersion = "23.11";
  # home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home = {
    inherit username;

    homeDirectory =
      if pkgs.stdenv.isLinux then "/home/${username}" else "/Users/${username}";

    # # Home Manager needs a bit of information about you and the
    # # paths it should manage.
    # home.username = "lswart";
    # # home.homeDirectory = "/home/lucas";
    # home.homeDirectory = "/home/lswart";
    # # home.homeDirectory = "/local/home/lswart";

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    stateVersion = "23.11";
    # home.stateVersion = "22.05";

    # instead of in ~/.config/nix/conf.nix :
    # from: https://nixos.wiki/wiki/Flakes
    #
    # nix = {
    #   package = pkgs.nix;
    #   settings.experimental-features = [ "nix-command" "flakes" ];
    # };

    packages = with pkgs; [
      # vim
      # curl
      # zsh
      # slack
      # ripgrep
      kubectl
      kubectx
      ko
      # kustomize
      ripgrep
      # istioctl
      # cloud-sql-proxy
      lsof
      socat
      httpie
      nurl
      pv
      imagemagick_light

      # # misc tools:
      tex

      # infra tools:
      k3d
      stern
      kind
      docker-compose
      jsonnet
      jsonnet-bundler
      jq
      yq-go
      k6
      krew
      k9s
      cfssl

      # linters:
      dockfmt
      nixfmt-classic
      shfmt
      shellcheck
      tflint
      nodePackages.prettier

      # dev tools:
      devenv
      direnv
      # (because sometimes we need to view packages in the nix store)
      yaml-language-server
      go
      postgresql
      dyff
      git
      gnumake
      mise

      # aws tools
      aws-iam-authenticator
      nodePackages_latest.aws-cdk

      # os tools:
      tmux
      nettools
      netcat
      htop
      inetutils
      bind
      wireguard-tools
      openssl

      # utils:
      delta
      fd
      fzf
      tree
      libqalculate
      exiftool
      ispell
      hunspell

      # golang
      gopls
      gomodifytags

      # rust
      rustup

      # node
      nodejs_20

      # macos
      # kitty

      gh
      hub

      buck2
      clang
      lld_19
      # rename
      # yamllint
      # go_1_18
      # sublime4
      # kubernetes-helm #Helm 3
      # pgcenter
      # keepass
      # ruby_2_7
    ];
  };

  programs.starship.enable = true;
  programs.starship.settings = { kubernetes = { disabled = false; }; };

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
