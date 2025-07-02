vim.lsp.config.ty = {
  filetypes = { "python" },
  root_markers = {
    "pyproject.toml",
  },
  cmd = { "uvx", "ty", "server" },
  settings = {
    python = {
      ty = {
        disableLanguageServices = true
      },
    },
  },
}
