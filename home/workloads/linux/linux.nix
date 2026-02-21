{pkgs, ...}: {
  home.file = {
    ".config/jj/config.toml".source = ../../dotfiles/jj/config.toml;
  };

  home.packages = [
    pkgs.localsend
  ];
}
