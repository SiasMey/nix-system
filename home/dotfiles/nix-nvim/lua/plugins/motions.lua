local function setup_leap()
  vim.keymap.set("n", "s", "<Plug>(leap)")
end

local function setup_pounce()
  local pounce = require("pounce")
  pounce.setup({
    accept_keys = "TNSERIAOGM",
    accept_best_key = "<enter>",
    multi_window = false,
    debug = false,
  })
  vim.keymap.set({ "n", "x", "o" }, "e", function()
    pounce.pounce()
  end)
end

local M = {}
M.setup = function()
  -- setup_leap()
  setup_pounce()
end
return M
