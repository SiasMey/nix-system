local M = {}

local function setup()
  require("difftastic-nvim").setup({
      download = true,              -- Auto-download pre-built binary (default: false)
      vcs = "jj",                    -- "jj" (default) or "git"
      highlight_mode = "treesitter", -- "treesitter" (default) or "difftastic"
      hunk_wrap_file = true,          -- Next hunk at last hunk goes to next file
      scroll_to_first_hunk = true,  -- Auto-scroll to first hunk after opening a file (default: true)
      snacks_picker = {
          enabled = false,          -- opt-in snacks.nvim integration (default: false)
          limit = 200,              -- number of revisions/commits to list in :DifftPick
          jj_log_revset = nil,      -- optional: jj revset for picker log (nil = omit -r and use jj default)
      },
      keymaps = {
          next_file = "<m-k>",
          prev_file = "<m-j>",
          next_hunk = "k",
          prev_hunk = "j",
          close = "q",
          focus_tree = "<Tab>",
          focus_diff = "<Tab>",
          select = "<CR>",
          goto_file = "gf",
      },
      tree = {
          width = 40,
          icons = {
              enable = true,    -- use nvim-web-devicons if available
              dir_open = "",
              dir_closed = "",
          },
      },
      highlights = {
          -- Override any highlight group (see Highlight Groups below)
          -- DifftAdded = { bg = "#2d4a3e" },
      },
  })
end

M.setup = setup

return M
