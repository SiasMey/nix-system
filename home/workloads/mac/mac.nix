{pkgs, ...}: {
  #podman needs to be installed via homebrew on mac
  #ghostty needs to be installed via homebrew on mac
  home.packages = [
    pkgs.aerospace
    pkgs.podman-tui
    pkgs.docker-compose
    pkgs.awscli2
    pkgs.terraform
    pkgs.podman-compose
    pkgs.amazon-ecr-credential-helper
    pkgs.gh
    pkgs.jira-cli-go
  ];

  home.file = {
    ".config/aerospace".source = ../../dotfiles/aerospace;
    ".config/jj/config.toml".source = ../../dotfiles/jj/config-work.toml;
  };

  programs.nushell = {
    shellAliases = {
      ji = "jira issue";
      jic = "jira issue create -C'Backend' -asias.mey@hpe.com";
      jil = "jira issue list -asias.mey@hpe.com -s'In Progress' -s'Selected for Development' --order-by=status";
      jilr = "jira issue list -asias.mey@hpe.com -s'In Review' -s'Blocked'";
      jilb = "jira issue list -asias.mey@hpe.com -s'Backlog' -s'Selected for Development' --order-by=status";
      # jiv = "jira issue view $JIRA_TICKET --comments 5";
      # jimb = "jira issue move $JIRA_TICKET 'Blocked'";
      # jimp = "jira issue move $JIRA_TICKET 'In progress'";
      # jimd = "jira issue move $JIRA_TICKET 'Selected for development'";
    };
    extraConfig = ''
      $env.path = ( $env.path | prepend "/opt/homebrew/bin")
      $env.path = ( $env.path | prepend "/opt/homebrew/sbin")
      $env.path = ( $env.path | prepend "~/.nix-profile/bin")
      $env.path = ( $env.path | prepend "/nix/var/nix/profiles/default/bin")
    '';
  };
}
