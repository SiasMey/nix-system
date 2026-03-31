local function setup_fzf_lua()
  local fzf_lua = require("fzf-lua")
  fzf_lua.setup({ "fzf-native" })
  vim.keymap.set("n", "<leader>ff", function()
    fzf_lua.files()
  end, { noremap = true, silent = true })
  vim.keymap.set("n", "<leader>b", function()
    fzf_lua.buffers()
  end, { noremap = true, silent = true })
  vim.keymap.set("n", "<leader>fd", function()
    fzf_lua.treesitter()
  end, { noremap = true, silent = true })
  fzf_lua.register_ui_select()
end

local M = {}
M.setup = function()
  setup_fzf_lua()
end
return M
