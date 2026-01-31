local function setup_leap()
  local leap = require("leap")
  leap.opts.highlight_unlabeled_phase_one_targets = true
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
