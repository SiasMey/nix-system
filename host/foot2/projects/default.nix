{...}: {
  virtualisation.oci-containers.containers = {
    vikunja = {
      image = "vikunja/vikunja:1.0.0";
      ports = ["127.0.0.1:9000:3456"];
      volumes = [
        "/var/lib/vikunja/files:/app/vikunja/files"
        "/var/lib/vikunja/db:/app/vikunja/db"
        "/var/lib/vikunja/config/config.yaml:/etc/vikunja/config.yml"
      ];
      environment = {
        VIKUNJA_PUBLIC_URL = "https://projects.dwarf-foot.dev/";
        VIKUNJA_DATABASE_TYPE = "sqlite";
        VIKUNJA_DATABASE_PATH = "/app/vikunja/db/vikunja.db";
      };
      # podman = {
      #   user = "vikunja";
      # };
    };
  };
}
