{...}: {
  services.caddy = {
    enable = true;
  };

  services.caddy.virtualHosts.localhost = {
    extraConfig = ''
      respond "Hello World!"
    '';
  };

  services.caddy.virtualHosts."foot2.tailb535da.ts.net" = {
    extraConfig = ''
      respond "Hello World!"
      tls internal
    '';
  };
}
