{...}: {
  home.file = {
    ".config/ghostty/config".source = ../dotfiles/ghostty/config;
    # ghostty has to be installed via homebrew on mac
  };
}
