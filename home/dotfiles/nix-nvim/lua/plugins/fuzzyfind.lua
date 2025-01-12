local function setup_telescope()
  local telescope = require("telescope")
  local builtin = require("telescope.builtin")
  telescope.load_extension("lsp_handlers")

  telescope.setup({
    defaults = {
      mappings = {
        i = {
          ["<C-y>"] = "select_default",
          ["<C-h>"] = "move_selection_next",
          ["<C-l>"] = "move_selection_previous",
          ["<C-n>"] = "close",
        },
        n = {
          ["<C-y>"] = "select_default",
          ["<C-h>"] = "move_selection_next",
          ["<C-l>"] = "move_selection_previous",
          ["<C-n>"] = "close",
        },
      },
    },
  })

  vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { noremap = true, silent = true })
  vim.keymap.set("n", "<leader>b", "<cmd>Telescope buffers<cr>", { noremap = true, silent = true })
  vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { noremap = true, silent = true })
  -- vim.api.nvim_set_keymap("n", "<leader>gs", "<cmd>Telescope git_status<cr>", { noremap = true, silent = true })
  vim.keymap.set("n", "<leader>dd", "<cmd>Telescope diagnostics<cr>", { noremap = true, silent = true })
  vim.keymap.set("n", "<leader>fws", "<cmd>Telescope lsp_workspace_symbols<cr>", { noremap = true, silent = true })
  vim.keymap.set("n", "<leader>fdf", function()
    builtin.treesitter({ symbols = "function" })
  end, { noremap = true, silent = true })
  vim.keymap.set("n", "<leader>fdc", function()
    builtin.treesitter({ symbols = "class" })
  end, { noremap = true, silent = true })
  vim.keymap.set("n", "zs", "<cmd>Telescope spell_suggest<cr>", { noremap = true, silent = true })
end

local function setup_fzf_lua()
  local fzf_lua = require("fzf-lua")
  fzf_lua.setup({ "fzf-native" })
  vim.keymap.set("n", "<leader>ff", function()
    fzf_lua.files()
  end, { noremap = true, silent = true })
  vim.keymap.set("n", "<leader>b", function()
    fzf_lua.buffers()
  end, { noremap = true, silent = true })
  vim.keymap.set("n", "<leader>fg", function()
    fzf_lua.live_grep()
  end, { noremap = true, silent = true })
  vim.keymap.set("n", "<leader>fd", function()
    fzf_lua.treesitter()
  end, { noremap = true, silent = true })
  fzf_lua.register_ui_select()
end

local M = {}
M.setup = function()
  -- setup_telescope()
  setup_fzf_lua()
end
return M
