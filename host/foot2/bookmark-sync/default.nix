{...}: {
  config.virtualisation.oci-containers.containers = {
    grimoire = {
      image = "goniszewski/grimoire:0.4.4";
      ports = ["0.0.0.0:5173:5173"];
      volumes = [
        "/var/lib/grimoire:/app/data/"
      ];
      environment = {
        PORT = "5173";
        # PUBLIC_HTTPS_ONLY=false;
        PUBLIC_SIGNUP_DISABLED = "false";
      };
    };
  };
}
