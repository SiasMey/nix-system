{config, ...}: {
  services.borgbackup.jobs.immich = {
    paths = "/var/lib/immich";
    encryption = {
      mode = "repokey-blake2";
      passCommand = "cat ${config.age.secrets.backup-pass-immich.path}";
    };
    environment.BORG_RSH = "ssh -i ${config.age.secrets.backup-key.path}";
    repo = "ssh://lw9uk9b2@lw9uk9b2.repo.borgbase.com/./repo";
    compression = "auto,zstd";
    startAt = "daily";
  };

  services.borgbackup.jobs.syncthing = {
    paths = "/var/lib/syncthing";
    encryption = {
      mode = "repokey-blake2";
      passCommand = "cat ${config.age.secrets.backup-pass-syncthing.path}";
    };
    environment.BORG_RSH = "ssh -i ${config.age.secrets.backup-key.path}";
    repo = "ssh://ay3rp5lw@ay3rp5lw.repo.borgbase.com/./repo";
    compression = "auto,zstd";
    startAt = "daily";
  };
}
