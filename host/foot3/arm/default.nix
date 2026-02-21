{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    lsscsi
  ];

  boot.kernelModules = ["sg"];

  users.groups.arm.gid = 1001;

  users.users.arm = {
    isNormalUser = true;
    home = "/home/arm";
    uid = 1001;
    homeMode = "755";
    group = "arm";
    extraGroups = ["cdrom" "video"];
  };

  # Creating folders in home directory
  # The base image ends up creating a lot of the folders as root, so this makes sure
  # the folders are setup with the right permissions
  #
  # NOTE: likely will also have to change permissions in files in the /home/arm/config directory (see readme)
  systemd.tmpfiles.rules = [
    "d /home/arm/music 0755 arm arm"
    "d /home/arm/Music 0755 arm arm"
    "d /home/arm/logs 0755 arm arm"
    "d /home/arm/media 0755 arm arm"
    "d /home/arm/media/raw 0755 arm arm"
    "d /home/arm/media/transcode 0755 arm arm"
    "d /home/arm/media/transcode/movies 0755 arm arm"
    "d /home/arm/media/transcode/unidentified 0755 arm arm"
    "d /home/arm/media/completed 0755 arm arm"
    "d /home/arm/movies 0755 arm arm"
    "d /home/arm/config 0755 arm arm"
    "d /home/arm/db 0755 arm arm"
  ];

  virtualisation.docker.enable = true;

  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      arm = {
        autoStart = true;
        image = "docker.io/automaticrippingmachine/automatic-ripping-machine:2.22.1";
        volumes = [
          "/home/arm:/home/arm"
          "/home/arm/music:/home/arm/music"
          "/home/arm/logs:/home/arm/logs"
          "/home/arm/media:/home/arm/media"
          "/home/arm/config:/etc/arm/config"
        ];
        ports = ["8080:8080"];
        environment = {
          ARM_UID = "1001";
          ARM_GID = "1001";
        };
        extraOptions = [
          "--privileged"
          "--device=/dev/sr0:/dev/sr0"
          "--device=/dev/sg0:/dev/sg0"
          "--device=/dev/dri/renderD128:/dev/dri/renderD128"
          "--device=/dev/dri/card1:/dev/dri/card1"
        ];
      };
    };
  };
}
