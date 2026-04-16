local function setup_leap()
  local leap = require("leap")
  vim.keymap.set("n", "m", "<Plug>(leap)")
  vim.keymap.set("n", "em", function()
    require("leap.remote").action()
  end)
end

local M = {}
M.setup = function()
  setup_leap()
end
return M
