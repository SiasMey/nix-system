# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  pkgs,
  lib,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./custom-hardware.nix
    ./nix-ld.nix
    ./desktop
    ./gaming
    ./users
    ./scripts
    ./sync.nix
    ./secrets.nix
    ../workloads/virtualization
    ../workloads/remote-access
    ../workloads/vpn
    ../workloads/flatpak
  ];

  # Set your time zone.
  time.timeZone = "Africa/Johannesburg";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  environment.systemPackages = with pkgs; [
    neovim
    wget
    git
    nh
    curl
    jq
    pciutils
    just
    parted
  ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  system.stateVersion = "24.05"; # Did you read the comment?
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  security.pam.u2f = {
    enable = true;
    settings = {
      interactive = true;
      cue = true;
      # origin = "pam://yubi";
      # authFile = pkgs.writeText "u2f-mappings" (lib.concatStrings [
      #   "siasm"
      #   ":XVxP5mjmm3ez/LRjdvdZzyaVtROQrGQDNRjuD8lcdHO+cjSOSJhuTDZRxvxUAt/4LadBoJPAAIapzD9/lVzsbw==,VPahnBoPo1lGxshvPX3u3zWR0fcRA1Ovh18/IpjNPKd+h/gDS9KrYfOEStO5G5UNPhNQddjUP9a4eyH1TYRyBg==,es256,+presence"
      # ]);
    };
  };

  security.pam.services = {
    login.u2fAuth = true;
    sudo.u2fAuth = true;
  };

  nix.extraOptions = ''
    extra-substituters = https://devenv.cachix.org
    extra-trusted-public-keys = devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=
  '';
}
