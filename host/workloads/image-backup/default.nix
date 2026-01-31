{...}: {
  services.immich.enable = true;
  services.immich.port = 2283;
  services.immich.host = "0.0.0.0";
  services.immich.database.enableVectors = false;
}
