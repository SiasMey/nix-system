local function setup_leap()
  local leap = require("leap")
  leap.opts.highlight_unlabeled_phase_one_targets = true
  vim.keymap.set("n", "m", "<Plug>(leap)")
  vim.keymap.set("n", "em", function()
    require("leap.remote").action()
  end)
end

local function setup_hop()
  local hop = require("hop")
  hop.setup({ keys = "tnseriaogm" })
end

local function setup_treehopper()
  local tsht = require("plugins.motions-treehopper")
  vim.keymap.set("n", "M", function()
    tsht.move({ side = "start" })
  end)
end

local M = {}
M.setup = function()
  setup_leap()
  -- setup_hop()
  -- setup_treehopper()
end
return M
