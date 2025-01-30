{pkgs, ...}: {
  home.packages = [
    pkgs.talosctl
    pkgs.age
    pkgs.sops
    pkgs.age-plugin-yubikey
  ];
}
