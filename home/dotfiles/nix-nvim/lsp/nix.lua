vim.lsp.config.nix = {
  filetypes = { "nix" },
  root_markers = { "flake.nix", ".git" },
  cmd = { "nixd" },
  settings = {
    nixd = {
      nixpkgs = {
        expr = "import <nixpkgs> { }",
      },
      options = {
        nixos = {
          expr = '(builtins.getFlake ("git+file://" + toString ./.)).nixosConfigurations.foot3.options',
        },
        home_manager = {
          expr = '(builtins.getFlake ("git+file://" + toString ./.)).homeConfigurations."siasm@foot3".options',
        },
      },
      formatting = {
        command = { "nixfmt" },
      },
    },
  },
}
