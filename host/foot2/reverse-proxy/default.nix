{...}: {
  services.caddy = {
    enable = true;
  };

  services.caddy.virtualHosts."photos.dwarf-foot.dev" = {
    extraConfig = ''
      reverse_proxy  :2283
    '';
  };

  services.caddy.virtualHosts."audiobook.dwarf-foot.dev" = {
    extraConfig = ''
      reverse_proxy  :8000
    '';
  };

  services.caddy.virtualHosts."audiobooks.dwarf-foot.dev" = {
    extraConfig = ''
      reverse_proxy  :8000
    '';
  };

  services.caddy.virtualHosts."bookmarks.dwarf-foot.dev" = {
    extraConfig = ''
      reverse_proxy  :3000
    '';
  };
}
