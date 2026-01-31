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
  vim.keymap.set({ "n", "x", "o" }, "<m-f>", function()
    require("nvim-treesitter-textobjects.move").goto_previous_start("@statement.outer", "textobjects")
  end)
  vim.keymap.set({ "n", "x", "o" }, "<m-c>", function()
    require("nvim-treesitter-textobjects.move").goto_next_start("@statement.outer", "textobjects")
  end)

  vim.keymap.set({ "n", "x", "o" }, "<m-w>", function()
    require("nvim-treesitter-textobjects.move").goto_previous_start("@parameter.inner", "textobjects")
  end)
  vim.keymap.set({ "n", "x", "o" }, "<m-x>", function()
    require("nvim-treesitter-textobjects.move").goto_next_start("@parameter.inner", "textobjects")
  end)

  vim.keymap.set({ "n", "x", "o" }, "<m-b>", function()
    require("nvim-treesitter-textobjects.move").goto_previous("@class.outer", "textobjects")
  end)
  vim.keymap.set({ "n", "x", "o" }, "<m-v>", function()
    require("nvim-treesitter-textobjects.move").goto_next("@class.outer", "textobjects")
  end)

  vim.keymap.set({ "n", "x", "o" }, "<m-p>", function()
    require("nvim-treesitter-textobjects.move").goto_previous("@function.outer", "textobjects")
  end)
  vim.keymap.set({ "n", "x", "o" }, "<m-d>", function()
    require("nvim-treesitter-textobjects.move").goto_next("@function.outer", "textobjects")
  end)
  -- swap
  vim.keymap.set("n", "<m-c-v>", function()
    require("nvim-treesitter-textobjects.swap").swap_next("@class.outer")
  end)
  vim.keymap.set("n", "<m-c-b>", function()
    require("nvim-treesitter-textobjects.swap").swap_previous("@class.outer")
  end)
  vim.keymap.set("n", "<m-c-d>", function()
    require("nvim-treesitter-textobjects.swap").swap_next("@function.outer")
  end)
  vim.keymap.set("n", "<m-c-p>", function()
    require("nvim-treesitter-textobjects.swap").swap_previous("@function.outer")
  end)
  vim.keymap.set("n", "<m-c-c>", function()
    require("nvim-treesitter-textobjects.swap").swap_next("@parameter.inner")
  end)
  vim.keymap.set("n", "<m-c-f>", function()
    require("nvim-treesitter-textobjects.swap").swap_previous("@parameter.inner")
  end)
  vim.keymap.set("n", "<m-c-x>", function()
    require("nvim-treesitter-textobjects.swap").swap_next("@statement.outer")
  end)
  vim.keymap.set("n", "<m-c-w>", function()
    require("nvim-treesitter-textobjects.swap").swap_previous("@statement.outer")
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

  vim.keymap.set({ "n" }, "<leader>srr", grug_file_rule, { desc = "Structural find and replace" })
  vim.keymap.set({ "n" }, "<leader>srp", grug_file_pattern, { desc = "Structural find and replace" })
end

local M = {}
M.setup = function()
  setup_text_objects()
  setup_ts_context()
  setup_treesitter()
  setup_refactoring()
  setup_indent_blankline()
  setup_grug_far()
end
return M
