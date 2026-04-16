local function setup_ts_context()
  require("treesitter-context").setup({
    enable = true,
    max_lines = 0,
    min_window_height = 0,
    line_numbers = true,
    multiline_threshold = 20,
    trim_scope = "outer",
    mode = "cursor",
    separator = nil,
    zindex = 20,
    on_attach = nil,
  })
end

local function setup_text_objects()
  require("nvim-treesitter-textobjects").setup({
    select = {
      lookbehind = true,
      lookahead = true,
      include_surrounding_whitespace = false,
      selection_modes = {
        ["@function.outer"] = "V",
        ["@function.inner"] = "V",
        ["@class.outer"] = "V",
        ["@class.inner"] = "V",
        ["@conditional.outer"] = "v",
        ["@conditional.inner"] = "v",
        ["@block.outer"] = "V",
        ["@block.inner"] = "V",
        ["@parameter.outer"] = "v",
        ["@parameter.inner"] = "v",
        ["@statement.outer"] = "v",
      },
    },
    move = {
      set_jumps = false,
    },
  })
  -- select
  vim.keymap.set({ "x", "o" }, "af", function()
    require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
  end)
  vim.keymap.set({ "x", "o" }, "if", function()
    require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
  end)
  vim.keymap.set({ "x", "o" }, "ac", function()
    require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects")
  end)
  vim.keymap.set({ "x", "o" }, "ic", function()
    require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects")
  end)
  vim.keymap.set({ "x", "o" }, "ab", function()
    require("nvim-treesitter-textobjects.select").select_textobject("@block.outer", "textobjects")
  end)
  vim.keymap.set({ "x", "o" }, "ib", function()
    require("nvim-treesitter-textobjects.select").select_textobject("@block.inner", "textobjects")
  end)
  vim.keymap.set({ "x", "o" }, "as", function()
    require("nvim-treesitter-textobjects.select").select_textobject("@statement.outer", "textobjects")
  end)
  vim.keymap.set({ "x", "o" }, "ap", function()
    require("nvim-treesitter-textobjects.select").select_textobject("@parameter.outer", "textobjects")
  end)
  vim.keymap.set({ "x", "o" }, "ip", function()
    require("nvim-treesitter-textobjects.select").select_textobject("@parameter.inner", "textobjects")
  end)
  -- move
  vim.keymap.set({ "n", "x", "o" }, "<m-b>", function()
    require("nvim-treesitter-textobjects.move").goto_previous_start("@parameter.inner", "textobjects")
  end)
  vim.keymap.set({ "n", "x", "o" }, "<m-v>", function()
    require("nvim-treesitter-textobjects.move").goto_next_start("@parameter.inner", "textobjects")
  end)
end

local function setup_treesitter()
  require("nvim-treesitter").setup({
    auto_install = false,
    ensure_installed = {},
    highlight = {
      enable = true,
    },
    indent = {
      enable = true,
    },
  })
end

local function setup_refactoring()
  require("refactoring").setup({
    -- prompt for return type
    prompt_func_return_type = {
      go = true,
      python = true,
    },
    -- prompt for function parameters
    prompt_func_param_type = {
      go = true,
      python = true,
    },
  })
end

local function setup_indent_blankline()
  require("ibl").setup({
    exclude = {
      filetypes = { "help", "alpha", "dashboard", "neo-tree", "trouble", "lazy" },
    },
  })
end

local function setup_grug_far()
  require("grug-far").setup({
    {
      astgrep = {
        -- path = "sg",
        extraArgs = "",
        placeholders = {
          enabled = true,

          search = "ex: $A && $A()   foo.bar($$$ARGS)   $_FUNC($_FUNC)",
          replacement = "ex: $A?.()   blah($$$ARGS)",
          replacement_lua = 'ex: return vars.A == "blah" and "foo(" .. vim.fn.join(vars.ARGS, ", ") .. ")" or match',
          filesFilter = "ex: *.lua   *.{css,js}   **/docs/*.md   (specify one per line, filters via ripgrep)",
          flags = "ex: --help (-h) --debug-query=ast --rewrite= (empty replace) --strictness=<STRICTNESS>",
          paths = "ex: /foo/bar   ../   ./hello\\ world/   ./src/foo.lua   ~/.config",
        },
      },
      ["astgrep-rules"] = {
        path = "ast-grep",

        -- extra args that you always want to pass
        -- like for example if you always want context lines around matches
        extraArgs = "",

        -- ast-grep docs:
        -- https://ast-grep.github.io/reference/sgconfig.html#languageglobs
        languageGlobs = {},

        -- placeholders to show in input areas when they are empty
        -- set individual ones to '' to disable, or set enabled = false for complete disable
        placeholders = {
          -- whether to show placeholders
          enabled = true,

          --  rules would normally be multi-line, but we don't support multi-line
          --  placeholders. rules is filled with a default-value though, so it's
          --  rare to see it empty
          rules = "e.g. id: my_rule_1 \\n language: lua\\nrule: \\n  pattern: await $A",
          filesFilter = "e.g. *.lua   *.{css,js}   **/docs/*.md   (specify one per line, filters via ripgrep)",
          flags = "e.g. --help (-h) --debug-query=ast --strictness=<STRICTNESS>",
          paths = "e.g. /foo/bar   ../   ./hello\\ world/   ./src/foo.lua   ~/.config",
        },
        -- defaults to fill into the inputs when loading or switching to this engine
        -- they only apply when non-nil
        defaults = {
          rules = nil,
          filesFilter = nil,
          flags = nil,
          paths = nil,
        },
      },
    },
    engine = "astgrep",
  })
  local function grug_file_pattern()
    require("grug-far").open({ prefills = { paths = vim.fn.expand("%") }, engine = "astgrep" })
  end
  local function grug_file_rule()
    require("grug-far").open({ prefills = { paths = vim.fn.expand("%") }, engine = "astgrep-rules" })
  end
  local function grug_rip_grep()
    require("grug-far").open({ engine = "ripgrep", transient = true })
  end

  vim.keymap.set({ "n" }, "<leader>srr", grug_file_rule, { desc = "Structural find and replace" })
  vim.keymap.set({ "n" }, "<leader>srp", grug_file_pattern, { desc = "Structural find and replace" })
  vim.keymap.set({ "n" }, "<leader>fg", grug_rip_grep, { desc = "Find and Replace" })
end

local function setup_treewalker()
  local treewalker = require("treewalker")
  treewalker.setup(
    -- The defaults:
    {
      -- Whether to briefly highlight the node after jumping to it
      highlight = true,

      -- How long should above highlight last (in ms)
      highlight_duration = 250,

      -- The color of the above highlight. Must be a valid vim highlight group.
      -- (see :h highlight-group for options)
      highlight_group = "CursorLine",

      -- Whether to create a visual selection after a movement to a node.
      -- If true, highlight is disabled and a visual selection is made in
      -- its place.
      select = false,

      -- Whether to use vim.notify to warn when there are missing parsers or incorrect options
      notifications = true,

      -- Whether the plugin adds movements to the jumplist -- true | false | 'left'
      --  true: All movements more than 1 line are added to the jumplist. This is the default,
      --        and is meant to cover most use cases. It's modeled on how { and } natively add
      --        to the jumplist.
      --  false: Treewalker does not add to the jumplist at all
      --  "left": Treewalker only adds :Treewalker Left to the jumplist. This seems the most
      --          likely jump to cause location confusion, so use this to minimize writes
      --          to the jumplist, while maintaining some ability to go back.
      jumplist = true,

      -- Whether movement, when inside the scope of some node, should be confined to that scope.
      -- When true, when moving through neighboring nodes inside some node, you won't be able to
      -- move outside of that scope via :Treewalker Up/Down. When false, if on a node at the end
      -- of a scope, movement will bring you to the next node of similar indentation/number of
      -- ancestor nodes, even when it is outside of the scope you're currently in.
      scope_confined = false,
    }
  )
end

local function setup_fluoride()
  local fluoride = require("fluoride")
  fluoride.setup({})
  vim.keymap.set("n", "<leader>S", "<cmd>Fluoride<cr>", { desc = "Fluoride" })
end

local M = {}
M.setup = function()
  setup_text_objects()
  setup_ts_context()
  setup_treesitter()
  setup_refactoring()
  setup_indent_blankline()
  setup_grug_far()
  setup_treewalker()
  setup_fluoride()
end
return M
