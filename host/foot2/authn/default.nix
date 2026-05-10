{config, ...}: {
  age.secrets.pocket-id = {
    file = ../../../secrets/pocket-id-key.age;
    owner = "pocket-id";
    group = "pocket-id";
    mode = "600";
  };
  services.pocket-id = {
    enable = true;
    credentials = {
      ENCRYPTION_KEY = config.age.secrets.pocket-id.path;
    };
    settings = {
      APP_URL = "https://auth.dwarf-foot.dev";
      TRUST_PROXY = true;
    };
  };
}
