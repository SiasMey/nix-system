{config, ...}: {
  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.device = "/dev/nvme0n1";

  boot.supportedFilesystems = ["zfs"];

  boot.zfs.devNodes = "/dev/disk/by-id";
  # boot.zfs.extraPools = ["space" "extra"];
  boot.zfs.forceImportRoot = false;

  networking.hostName = "foot2"; # Define your hostname.
  networking.hostId = "a0615630";

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
}
