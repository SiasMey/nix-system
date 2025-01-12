{pkgs, ...}: {
  home.packages = [
    pkgs.aerospace
  ];

  home.file = {
    ".config/aerospace".source = ../dotfiles/aerospace;
  };
}
