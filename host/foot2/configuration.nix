# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{pkgs, ...}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./custom-hardware.nix
    # ./load-credentials.nix
    ./scripts
    ./file-backup
    ./bookmark-sync
    ./reverse-proxy
    ./authn
    ./projects
    ./homebox
    ../workloads/virtualization
    ../workloads/remote-access
    ../workloads/file-sync
    ../workloads/image-backup
    ../workloads/vpn
    ../workloads/rss-feed
    ../workloads/audiobooks
    ../../users
  ];

  # Set your time zone.
  time.timeZone = "Africa/Johannesburg";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_ZA.UTF-8";

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "za";
    variant = "";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    git
    bws
    nss.tools
    openssl
    pocket-id
    mailcap
  ];

  environment.enableAllTerminfo = true;

  networking.firewall.enable = false;
  # networking.extraHosts = ''
  #   127.0.0.1 auth.dwarf-foot.dev
  #   127.0.0.1 bookmarks.dwarf-foot.dev
  #   127.0.0.1 projects.dwarf-foot.dev
  # '';

  nix.settings.experimental-features = [
    "flakes"
    "nix-command"
  ];

  system.stateVersion = "24.05"; # Did you read the comment?

  age.secrets.backup-pass-immich.file = ../../secrets/backup-pass-immich.age;
  age.secrets.backup-pass-syncthing.file = ../../secrets/backup-pass-syncthing.age;
  age.secrets.backup-key.file = ../../secrets/backup-key.age;
}
