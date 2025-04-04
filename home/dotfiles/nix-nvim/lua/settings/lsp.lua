vim.lsp.enable({ "luals", "basedpyright", "ruff", "nix", "spelling", "writing" })

vim.lsp.config("*", {
  root_markers = { ".git" },
})

local function enable_workspace_diagnostics()
  for _, lsp_client in ipairs(vim.lsp.get_clients()) do
    require("workspace-diagnostics").populate_workspace_diagnostics(lsp_client, 0)
  end
end

local function toggle_inlay()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled(), { bufnr = 0 })
end

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("my.lsp", {}),
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    if client:supports_method("textDocument/implementation") then
      -- Create a keymap for vim.lsp.buf.implementation ...
    end

    -- Enable auto-completion. Note: Use CTRL-Y to select an item. |complete_CTRL-Y|
    if client:supports_method("textDocument/completion") then
      -- Optional: trigger autocompletion on EVERY keypress. May be slow!
      -- local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
      -- client.server_capabilities.completionProvider.triggerCharacters = chars
      vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
    end

    if client:supports_method("textDocument/inlayHint") or client.server_capabilities.inlayHintProvider then
      vim.keymap.set("n", "<space>i", toggle_inlay)
    else
      vim.keymap.set("n", "<space>i", "<Nop>")
    end

    vim.keymap.set("n", "<space>D", enable_workspace_diagnostics)
  end,
})
