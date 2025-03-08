{...}: {
  services = {
    syncthing = {
      enable = true;
      group = "users";
      user = "meysi";
      dataDir = "/home/meysi/sync";
      configDir = "/home/meysi/sync/.config/syncthing";
      overrideDevices = false; # overrides any devices added or deleted through the WebUI
      overrideFolders = false; # overrides any folders added or deleted through the WebUI
      settings = {
        devices = {};
        folders = {};
      };
    };
  };
}
