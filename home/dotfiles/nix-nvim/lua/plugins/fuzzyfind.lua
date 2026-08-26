local function setup_fzf_lua()
  local fzf_lua = require("fzf-lua")
  fzf_lua.setup({ "fzf-native" })
  -- fzf_lua.register_ui_select()

  vim.keymap.set("n", "<leader>ff", function()
    fzf_lua.files()
  end, { noremap = true, silent = true })
  vim.keymap.set("n", "<leader>fg", function()
    fzf_lua.live_grep()
  end, { noremap = true, silent = true })
  vim.keymap.set("n", "<leader>b", function()
    fzf_lua.buffers()
  end, { noremap = true, silent = true })
  vim.keymap.set("n", "M", function()
    fzf_lua.treesitter()
  end, { noremap = true, silent = true })
end

local M = {}
M.setup = function()
  setup_fzf_lua()
end
return M
