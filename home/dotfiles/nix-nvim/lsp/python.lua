vim.lsp.config.ty = {
  filetypes = { "python" },
  root_markers = {
    "pyproject.toml",
  },
  cmd = { "uvx", "ty", "server" },
  settings = {
    python = {
      ty = {
        disableLanguageServices = false
      },
    },
  },
}
vim.lsp.config.ruff = {
  filetypes = { "python" },
  root_markers = {
    "ruff.toml",
  },
  cmd = { "uv", "run", "ruff", "server" },
  settings = {},
}
vim.lsp.config.basedpyright = {
  filetypes = { "python" },
  root_markers = {
    "pyrightconfig.json",
  },
  cmd = { "uv", "run", "basedpyright-langserver", "--stdio" },
  settings = {
    basedpyright = {
      disableOrganizeImports = true,
      disableLanguageServices = true,
      analysis = {
        autoImportCompletions = false,
        useLibraryCodeForTypes = false,
      },
    },
  },
}
