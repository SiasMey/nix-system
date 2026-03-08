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

  services.caddy.virtualHosts."boxes.dwarf-foot.dev" = {
    extraConfig = ''
      reverse_proxy  127.0.0.1:7745
    '';
  };

  services.caddy.virtualHosts."projects.dwarf-foot.dev" = {
    extraConfig = ''
      reverse_proxy  :9000
    '';
  };

  services.caddy.virtualHosts."auth.dwarf-foot.dev" = {
    extraConfig = ''
      reverse_proxy  :1411
    '';
  };
}
