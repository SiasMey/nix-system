vim.lsp.config.nix = {
  filetypes = { "nil" },
  root_markers = { "flake.nix", ".git" },
  cmd = { "nix" },
  settings = {
    ["nil"] = {
      formatting = {
        command = { "nixfmt" },
      },
    },
  },
}
