vim.lsp.config.ruff = {
  filetypes = { "python" },
  root_markers = {
    "pyproject.toml",
    "ruff.toml",
    ".ruff.toml",
    ".git",
  },
  cmd = { "ruff", "server" },
  settings = {},
}
