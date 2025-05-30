vim.lsp.config.basedpyright = {
  filetypes = { "python" },
  root_markers = {
    "pyrightconfig.json",
  },
  cmd = { "uv", "run", "basedpyright-langserver", "--stdio" },
  settings = {
    basedpyright = {
      disableOrganizeImports = true,
      analysis = {
        autoImportCompletions = false,
        useLibraryCodeForTypes = false,
      },
    },
  },
}
