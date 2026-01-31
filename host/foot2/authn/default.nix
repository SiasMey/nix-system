{...}: {
  services.pocket-id = {
    enable = true;
    credentials = {
      ENCRYPTION_KEY = "/var/run/pocket-id/encryption-key";
    };
    settings = {
      APP_URL = "https://auth.dwarf-foot.dev";
      TRUST_PROXY = true;
    };
  };
}
