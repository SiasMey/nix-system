vim.lsp.config.ruff = {
  filetypes = { "python" },
  root_markers = {
    "ruff.toml",
  },
  cmd = { "uv", "run", "ruff", "server" },
  settings = {},
}
