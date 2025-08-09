{...}: {
  services.pocket-id = {
    enable = true;
    settings = {
      APP_URL = "https://auth.dwarf-foot.dev";
      TRUST_PROXY = true;
    };
  };
}
