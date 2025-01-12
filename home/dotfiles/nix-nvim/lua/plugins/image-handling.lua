local function setup_imgclip()
  require("img-clip").setup()
  vim.keymap.set("n", "<leader>P", "<cmd>PasteImage<cr>", { desc = "Paste image from system clipboard" })
end

local M = {}
M.setup = function()
  -- setup_imgclip()
end
return M
