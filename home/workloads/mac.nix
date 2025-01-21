{pkgs, ...}: {
  #podman needs to be installed via homebrew on mac
  #ghostty needs to be installed via homebrew on mac
  home.packages = [
    pkgs.aerospace
    pkgs.podman-tui
    pkgs.docker-compose
    pkgs.awscli2
    pkgs.terraform
  ];

  home.file = {
    ".config/aerospace".source = ../dotfiles/aerospace;
  };
}
