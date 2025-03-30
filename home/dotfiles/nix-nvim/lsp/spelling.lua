vim.lsp.config.spelling = {
  root_markers = { "typos.toml", ".typos.toml", "_types.toml" },
  cmd = { "typos-lsp" },
  init_options = {
    config = "~/.config/typos/typos.toml",
    diagnosticSeverity = "Error",
  },
}
