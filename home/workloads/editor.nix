{pkgs, ...}: let
  workspace-diagnostics = pkgs.vimUtils.buildVimPlugin {
    name = "workspace-diagnostics.nvim";
    src = pkgs.fetchFromGitHub {
      owner = "artemave";
      repo = "workspace-diagnostics.nvim";
      rev = "573ff93c47898967efdfbc6587a1a39e3c2d365e";
      hash = "sha256-lBj4KUPmmhtpffYky/HpaTwY++d/Q9socp/Ys+4VeX0=";
    };
  };
  nvim-treehopper = pkgs.vimUtils.buildVimPlugin {
    name = "nvim-treehopper";
    src = pkgs.fetchFromGitHub {
      owner = "mfussenegger";
      repo = "nvim-treehopper";
      rev = "e87002968983ed23836dfad53bcf023e609db42d";
      hash = "sha256-JLL+w66izB89XhbTY8lRTqEhgBmMzPnV013jbhZDnqU=";
    };
  };
  neo-solarized-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "neo-solarized-nvim";
    src = pkgs.fetchFromGitHub {
      owner = "Tsuzat";
      repo = "NeoSolarized.nvim";
      rev = "bdfcdd056c4c73b10fc6f42f0c2d0df839ff49ae";
      hash = "sha256-mZll6RsA11oJYKnbV6K/oAWr+l+8vNXc+X44zplWq8s=";
    };
  };
in {
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.packages = [
    # # Language Servers
    # # Language tools
    pkgs.alejandra
    pkgs.ast-grep
    pkgs.basedpyright
    pkgs.bash-language-server
    pkgs.beautysh
    pkgs.d2
    pkgs.earthlyls
    pkgs.efm-langserver
    pkgs.fixjson
    pkgs.gitui
    pkgs.golangci-lint-langserver
    pkgs.gopls
    pkgs.jq
    pkgs.lua-language-server
    pkgs.marksman
    pkgs.mdformat
    pkgs.mermaid-cli
    pkgs.nil
    pkgs.nixfmt-rfc-style
    pkgs.nufmt
    pkgs.openscad-lsp
    pkgs.rust-analyzer
    pkgs.stylua
    pkgs.taplo
    pkgs.terraform-ls
    pkgs.typos-lsp
    pkgs.uv
    pkgs.yaml-language-server
    pkgs.yq-go
    (pkgs.vale.withStyles (s: [s.google s.alex s.write-good s.proselint]))
    pkgs.vale-ls
  ];

  programs.fzf = {
    enable = true;
  };

  programs.ripgrep = {
    enable = true;
  };

  programs.fd = {
    enable = true;
  };

  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      cmp-buffer
      cmp-cmdline
      cmp_luasnip
      cmp-nvim-lsp
      cmp-nvim-lsp-signature-help
      cmp-nvim-lua
      cmp-path
      conform-nvim
      fzf-lua
      git-conflict-nvim
      gitsigns-nvim
      grug-far-nvim
      harpoon2
      hop-nvim
      indent-blankline-nvim
      lazydev-nvim
      leap-nvim
      lspkind-nvim
      lualine-lsp-progress
      lualine-nvim
      luasnip
      mini-nvim
      neogen
      neo-solarized-nvim
      nvim-cmp
      nvim-lspconfig
      nvim-notify
      nvim-treehopper
      nvim-treesitter-context
      nvim-treesitter-parsers.just
      nvim-treesitter-textobjects
      nvim-treesitter.withAllGrammars
      oil-nvim
      refactoring-nvim
      solarized-nvim
      workspace-diagnostics
    ];

    extraLuaConfig = ''
      require("settings")
      require("plugins")
    '';
  };

  xdg.configFile."nvim" = {
    recursive = true;
    source = ../dotfiles/nix-nvim;
  };
}
