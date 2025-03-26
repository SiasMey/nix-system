{
  pkgs,
  config,
  ...
}: {
  programs.zsh.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.meysi = {
    isNormalUser = true;
    description = "Sias Mey";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    openssh.authorizedKeys.keys = [
      "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIJf6EqaVpGEIepdFSzJ+eZl/F6zACCJObvI5HsKneMVbAAAACnNzaDpnaXRodWI= meysi"
    ];
    shell = pkgs.zsh;

    programs.ssh = {
      startAgent = true;
      extraConfig = ''
        Host *
          IdentityFile ${config.age.secrets.secret1.path}
      '';
    };
  };

  users.users.siasm = {
    isNormalUser = true;
    description = "Sias Mey";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    openssh.authorizedKeys.keys = [
      "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIJf6EqaVpGEIepdFSzJ+eZl/F6zACCJObvI5HsKneMVbAAAACnNzaDpnaXRodWI= meysi"
    ];
    shell = pkgs.zsh;

    programs.ssh = {
      startAgent = true;
      extraConfig = ''
        Host *
          IdentityFile ${config.age.secrets.secret1.path}
      '';
    };
  };

  users.defaultUserShell = pkgs.zsh;
}
