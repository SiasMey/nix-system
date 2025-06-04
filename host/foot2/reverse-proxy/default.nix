{...}: {
  services.caddy = {
    enable = true;
  };

  services.caddy.virtualHosts."192.168.68.200" = {
    extraConfig = ''
      tls internal
      reverse_proxy :2283
    '';
  };

  services.caddy.virtualHosts."foot2.tailb535da.ts.net" = {
    extraConfig = ''
      reverse_proxy  :2283
    '';
  };
}
