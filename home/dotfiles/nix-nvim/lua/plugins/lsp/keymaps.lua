local M = {}

local function toggle_inlay()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled(), { bufnr = 0 })
end

local function enable_workspace_diagnostics()
  for _, lsp_client in ipairs(vim.lsp.get_clients()) do
    require("workspace-diagnostics").populate_workspace_diagnostics(lsp_client, 0)
  end
end

function M.on_attach(client, buffer)
  local opts = { buffer = buffer }
  vim.keymap.set("n", "<space>d", vim.diagnostic.open_float, opts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
  vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)
  vim.keymap.set("n", "<c-m>", vim.lsp.buf.hover, opts)
  vim.keymap.set({ "n", "i" }, "<c-e>", vim.lsp.buf.signature_help, opts)
  vim.keymap.set({ "n", "v" }, "<space>c", vim.lsp.buf.code_action, opts)
  vim.keymap.set({ "n", "v" }, "<space>f", function()
    require("conform").format({ bufnr = buffer })
  end, opts)
  vim.keymap.set("n", "<space>n", vim.lsp.buf.rename, opts)

  if client.supports_method("textDocument/inlayHint") or client.server_capabilities.inlayHintProvider then
    vim.keymap.set("n", "<space>i", toggle_inlay, opts)
  else
    vim.keymap.set("n", "<space>i", "<Nop>", opts)
  end

  vim.keymap.set("n", "<space>D", enable_workspace_diagnostics, opts)
end

return M
