{
  pkgs,
  config,
  ...
}: {
  programs.zsh.enable = true;
  programs.nushell.enable = true;

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
      "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIASVZBrLYFUq0VNtr8PCYvc5CCg3EZ2xmTHBsYl9ER3/AAAABHNzaDo= siasm+backup"
    ];
    shell = pkgs.nushell;
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
      "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIASVZBrLYFUq0VNtr8PCYvc5CCg3EZ2xmTHBsYl9ER3/AAAABHNzaDo= siasm+backup"
    ];
    shell = pkgs.nushell;
  };

  programs.ssh = {
    startAgent = true;
  };
  users.defaultUserShell = pkgs.nushell;
}
