{pkgs, ...}: {
  home.stateVersion = "24.05"; # Please read the comment before changing.

  fonts.fontconfig = {
    enable = true;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    MANPAGER = "bat -l man -p";
    PAGER = "ov";
    # MANPAGER = "ov --section-delimiter '^[^\s]' --section-header";  # better colours first
  };

  home.packages = [
    pkgs.bottom
    pkgs.cargo
    pkgs.dust
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
    pkgs.ov
    pkgs.jujutsu
    pkgs.jjui
    pkgs.opencode
    pkgs.ragenix
  ];

  home.file = {
    ".config/ov/config.yaml".source = ../dotfiles/ov/config.yaml;
    ".config/bottom/bottom.toml".source = ../dotfiles/bottom/bottom.toml;
    ".config/starship.toml".source = ../dotfiles/starship/starship.toml;
    ".config/tmux/theme.conf".source = ../dotfiles/tmux/theme.conf;
    ".config/direnv/direnvrc".source = ../dotfiles/direnv/direnvrc;
  };

  programs.home-manager.enable = true;
  nix = {
    package = pkgs.nix;
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  programs.keychain = {
    enable = true;
    extraFlags = ["--quiet" "--quick"];
    enableZshIntegration = true;
    keys = ["~/.ssh/id_ed25519"];
  };

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Sias Mey";
        email = "siasmey@gmail.com";
      };
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

  programs.carapace = {
    enable = true;
    enableZshIntegration = true;
    enableNushellIntegration = true;
  };

  programs.zsh = {
    enable = true;
    initContent = builtins.readFile ../dotfiles/zsh/zshrc;
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

  programs.nushell = {
    enable = true;
    # The config.nu can be anywhere you want if you like to edit your Nushell with Nu
    configFile.source = ../dotfiles/nushell/config.nu;
    # for editing directly to config.nu
    extraConfig = ''
      let carapace_completer = {|spans|
        carapace $spans.0 nushell ...$spans | from json
      }
      $env.config = {
        buffer_editor: "nvim"
        show_banner: false
        completions: {
          case_sensitive: false # case-sensitive completions
          quick: true    # set to false to prevent auto-selecting completions
          partial: true    # set to false to prevent partial filling of the prompt
          algorithm: "fuzzy"    # prefix or fuzzy
          external: {
          # set to false to prevent nushell looking into $env.PATH to find more suggestions
              enable: true
          # set to lower can improve completion performance at the cost of omitting some options
              max_results: 100
              completer: $carapace_completer # check 'carapace_completer'
            }
        }
      }
      $env.path ++= ["~/bin"]
      $env.path ++= ["~/.local/bin"]
    '';

    shellAliases = {
      vi = "nvim";
      vim = "nvim";
      cat = "bat --paging=never";
      docker = "podman";
      nu-open = "open";
      open = "^open";
      lt = "lsd --tree";
      ll = "ls -l";
      la = "ls -a";
      lla = "ls -la";
    };

    environmentVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      FZF_DEFAULT_OPTS = "--bind=ctrl-y:accept,ctrl-n:abort,ctrl-l:up,ctrl-h:down";
      MANPAGER = "bat -l man -p";
      PAGER = "ov";
    };
  };

  programs.zoxide = {
    enable = true;
  };

  programs.lsd = {
    enable = true;
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

  programs.atuin = {
    enable = false;
    enableNushellIntegration = true;
    enableZshIntegration = true;
    settings = {
      filter_mode = "global";
      filter_mode_shell_up_key_binding = "directory";
    };
    forceOverwriteSettings = true;
  };

  programs.tmux = {
    enable = true;
    extraConfig = builtins.readFile ../dotfiles/tmux/tmux.conf;
  };
}
