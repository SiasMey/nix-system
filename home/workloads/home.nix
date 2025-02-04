{pkgs, ...}: {
  home.stateVersion = "24.05"; # Please read the comment before changing.

  fonts.fontconfig = {
    enable = true;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    MANPAGER = "bat -l man -p";
  };

  home.packages = [
    pkgs.atuin
    pkgs.bottom
    pkgs.cargo
    pkgs.dust
    pkgs.earthly
    pkgs.fastfetch
    pkgs.just
    pkgs.kubectl
    pkgs.mermaid-cli
    pkgs.presenterm
    pkgs.python3Minimal
    pkgs.rustc
    pkgs.uv
    pkgs.zig
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.vacuum-go
  ];

  home.file = {
    ".config/starship.toml".source = ../dotfiles/starship/starship.toml;
    ".config/tmux/theme.conf".source = ../dotfiles/tmux/theme.conf;
  };

  programs.home-manager.enable = true;
  nix = {
    package = pkgs.nix;
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  programs.git = {
    enable = true;
    userName = "Sias Mey";
    userEmail = "siasmey@gmail.com";
    extraConfig = {
      init.defaultBranch = "trunk";
      push.autoSetupRemote = true;
      pull.rebase = true;
      diff.tool = "nvim -d";
      core = {
        editor = "nvim";
        autocrlf = false;
        eol = "lf";
      };
      alias = {
        default-branch = "!git symbolic-ref refs/remotes/origin/HEAD | cut -f4 -d/";
        wt-default-branch = ''!cat "$(git worktree list --porcelain | grep \.bare | cut -d ' ' -f 2)/HEAD" | cut -d '/' -f 3'';
        sync-default-branch = "!git remote set-head origin --auto";
        sync = "!git fetch -p && git merge origin/$(git default-branch)";
        wt-sync = "!git fetch -p && git merge origin/$(git wt-default-branch)";
      };
    };
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.zsh = {
    enable = true;
    initExtra = builtins.readFile ../dotfiles/zsh/zshrc;
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.bat = {
    enable = true;
    config = {
      theme = "Solarized (light)";
    };
  };

  programs.zoxide = {
    enable = true;
  };

  programs.lsd = {
    enable = true;
    enableAliases = true;
  };

  programs.nh = {
    enable = true;
  };

  programs.jq = {
    enable = true;
  };

  programs.k9s = {
    enable = true;
  };

  programs.tealdeer = {
    enable = true;
  };

  programs.go = {
    enable = true;
  };

  programs.tmux = {
    enable = true;
    extraConfig = builtins.readFile ../dotfiles/tmux/tmux.conf;
  };

  programs.gitui = {
    enable = true;
    keyConfig = ../dotfiles/gitui/key_bindings.ron;
    theme = ../dotfiles/gitui/theme.ron;
  };
}
