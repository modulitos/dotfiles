# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    hostName = "oolong"; # Define your hostname.
    # Pick only one of the below networking options.
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    networkmanager.enable =
      true; # Easiest to use and most distros use this by default.
  };

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot =
    true; # powers up the default Bluetooth controller on boot

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # https://nixos.org/manual/nix/stable/command-ref/conf-file.html#conf-experimental-features
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Automatic Garbage Collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.lucas = {
    isNormalUser = true;
    extraGroups = [
      "wheel" # Enable ‘sudo’ for the user.
      "networkmanager"
      "video" # brightness/volume keys
    ];
    # packages = myPackages.myPackages;
    packages = with pkgs; [
      firefox
      emacs
      sqlite
      direnv
      shellcheck
      python3
      gcc
      libgcc
      bemenu
      swaylock
      swayidle
      swayrbar
      wl-clipboard
      tmux
      sbcl # lisp compiler
      emacsPackages.editorconfig
      spotify
      zoom-us
      anki
      dropbox-cli
      slack
      delta
      bluez
      pavucontrol
      # (import (fetchTarball {
      #   url = "https://install.devenv.sh/latest";
      #   sha256 = "0wj5455mk0kgm4vnvqia6x4qhkwwf3cn07pdsd4wmfdbp9rxr44a";
      # }
      # )).default

      dunst
      kanshi
      signal-desktop
      # for "notify-send" command to make desktop notifications:
      libnotify
      # for the "play" command to play audio:
      sox
      chromium
    ];
    shell = pkgs.zsh;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    wayland
    grim
    slurp
    ripgrep
    brightnessctl
    file
  ];

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [ "spotify" "zoom" "slack" "dropbox" ];

  programs.sway = { enable = true; };

  # qt.style = "adwaita";

  programs.light.enable = true;

  programs.zsh.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    # hostKeys = services.openssh.hostKeys ++ [
    # hostKeys = [
    #   # defaults (ideally we should override them instead of duplicating config):
    #   {
    #     bits = 4096;
    #     path = "/etc/ssh/ssh_host_rsa_key";
    #     type = "rsa";
    #   }
    #   {
    #     path = "/etc/ssh/ssh_host_ed25519_key";
    #     type = "ed25519";
    #   }
    #   # overrides:
    #   {
    #     bits = 4096;
    #     path = "/home/lucas/.ssh/github_key";
    #     type = "rsa";
    #   }
    #   {
    #     bits = 4096;
    #     path = "/home/lucas/.ssh/gitlab_key";
    #     type = "rsa";
    #   }
    # ];
  };

  # https://nixos.wiki/wiki/Extend_NixOS#Quick_Implementation
  systemd.services.dbox = {
    after = [ "network.target" ];
    description = "Dropbox daemon.";
    wantedBy = [ "multi-user.target" ];

    # man systemd.service
    serviceConfig = {
      Type = "exec";
      User = "lucas";
      ExecStart = "${pkgs.dropbox}/bin/dropbox";
    };
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "23.11"; # Did you read the comment?

}

