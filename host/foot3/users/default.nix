{pkgs, ...}: {
  programs.zsh.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.siasm = {
    isNormalUser = true;
    description = "Sias Mey";
    extraGroups = [
      "networkmanager"
      "wheel"
      "cdrom"
    ];
    openssh.authorizedKeys.keys = [
      "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIJf6EqaVpGEIepdFSzJ+eZl/F6zACCJObvI5HsKneMVbAAAACnNzaDpnaXRodWI= siasm"
      "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIASVZBrLYFUq0VNtr8PCYvc5CCg3EZ2xmTHBsYl9ER3/AAAABHNzaDo= siasm+backup"
    ];
    shell = pkgs.nushell;
  };
  users.defaultUserShell = pkgs.nushell;

  environment.variables.EDITOR = "nvim";

  programs.ssh = {
    startAgent = true;
  };
}
