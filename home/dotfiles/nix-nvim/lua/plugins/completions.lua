local setup_blink = function()
  local blink = require("blink.cmp")

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    -- See :h blink-cmp-config-keymap for defining your own keymap
    keymap = {
      preset = "none",
      ["<C-l>"] = { "select_prev", "fallback" },
      ["<C-h>"] = { "select_next", "fallback" },
      ["<C-j>"] = { "scroll_documentation_up", "fallback" },
      ["<C-k>"] = { "scroll_documentation_down", "fallback" },
      ["<C-n>"] = { "cancel", "fallback" },
      ["<C-y>"] = { "select_and_accept", "fallback" },
    },

    -- (Default) Only show the documentation popup when manually triggered
    completion = { documentation = { auto_show = true } },

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
      default = { "lsp", "path", "buffer" },
    },

    cmdline = {
      keymap = { preset = "inherit" },
      completion = { menu = { auto_show = true } },
    },

    -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
    -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
    -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
    --
    -- See the fuzzy documentation for more information
    fuzzy = { implementation = "prefer_rust_with_warning" },
  }

  blink.setup(opts)
end

local M = {}
M.setup = function()
  setup_blink()
end
return M
