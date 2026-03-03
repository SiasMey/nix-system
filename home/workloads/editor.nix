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
    pkgs.alejandra
    pkgs.ast-grep
    pkgs.bash-language-server
    pkgs.beautysh
    pkgs.d2
    pkgs.efm-langserver
    pkgs.fixjson
    pkgs.golangci-lint-langserver
    pkgs.gopls
    pkgs.jq
    pkgs.lua-language-server
    # pkgs.marksman
    pkgs.mdformat
    pkgs.mermaid-cli
    pkgs.nixfmt
    pkgs.nufmt
    pkgs.openscad-lsp
    pkgs.rust-analyzer
    pkgs.stylua
    pkgs.tombi
    pkgs.terraform-ls
    pkgs.typos-lsp
    pkgs.uv
    pkgs.just-lsp
    pkgs.yaml-language-server
    pkgs.yq-go
    (pkgs.vale.withStyles (s: [
      s.google
      s.alex
      s.write-good
      s.proselint
    ]))
    pkgs.vale-ls
    pkgs.nixd
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
      # primeagen-99
      conform-nvim
      fzf-lua
      grug-far-nvim
      harpoon2
      indent-blankline-nvim
      lazydev-nvim
      leap-nvim
      lspkind-nvim
      luasnip
      neogen
      neo-solarized-nvim
      blink-cmp
      blink-compat
      nvim-notify
      nvim-treesitter-context
      nvim-treesitter-parsers.just
      nvim-treesitter-textobjects
      nvim-treesitter.withAllGrammars
      oil-nvim
      refactoring-nvim
      solarized-nvim
      workspace-diagnostics
    ];

    initLua = ''
      require("settings")
      require("plugins")
    '';
  };

  xdg.configFile."nvim" = {
    recursive = true;
    source = ../dotfiles/nix-nvim;
  };
}
