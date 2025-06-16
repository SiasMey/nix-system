{...}: {
  services.tailscale.enable = true;
  services.tailscale.permitCertUid = "caddy";
}
