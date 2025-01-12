local setup_cmp = function()
  local cmp = require("cmp")
  local lspkind = require("lspkind")

  cmp.setup({
    formatting = {
      format = lspkind.cmp_format({
        mode = "symbol_text",
        menu = {
          buffer = "[Buffer]",
          path = "[Path]",
          nvim_lsp = "[LSP]",
          luasnip = "[LuaSnip]",
          nvim_lua = "[Lua]",
          copilot = "[Copilot]",
          git = "[Git]",
        },
      }),
    },
    view = {
      entries = "custom",
    },
    window = {
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
    },
    mapping = {
      ["<C-k>"] = cmp.mapping.scroll_docs(4),
      ["<C-j>"] = cmp.mapping.scroll_docs(-4),
      ["<C-h>"] = cmp.mapping.select_next_item(),
      ["<C-l>"] = cmp.mapping.select_prev_item(),
      ["<C-n>"] = cmp.mapping.abort(),
      ["<C-y>"] = cmp.mapping.confirm({
        select = true,
        behavior = cmp.ConfirmBehavior.Replace,
      }),
    },
    sources = {
      { name = "nvim_lsp", group_index = 1, max_item_count = 25 },
      { name = "git", group_index = 1, max_item_count = 5 },
      { name = "buffer", group_index = 1, max_item_count = 3, keyword_length = 5 },
      { name = "path", group_index = 1, max_item_count = 3 },
      { name = "luasnip", group_index = 1, max_item_count = 5 },
      { name = "lazydev", group_index = 2, max_item_count = 15 },
      { name = "nvim_lsp_signature_help" },
    },
    snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end,
    },
  })

  cmp.setup.cmdline(":", {
    mapping = {
      ["<C-h>"] = {
        c = function()
          cmp.select_next_item()
        end,
      },
      ["<C-l>"] = {
        c = function()
          cmp.select_prev_item()
        end,
      },
      ["<C-n>"] = {
        c = function()
          cmp.abort()
        end,
      },
      ["<C-y>"] = {
        c = function(fallback)
          if cmp.visible() then
            local i = cmp.get_selected_entry()

            if i == nil then
              cmp.select_next_item()
            end

            cmp.confirm()
            fallback()
          else
            fallback()
          end
        end,
      },
    },
    view = {
      entries = { name = "wildmenu", separator = "|" },
    },
    sources = cmp.config.sources({
      { name = "path" },
    }, {
      {
        name = "cmdline",
        option = {
          ignore_cmds = { "Man", "!" },
        },
      },
    }),
  })
end

local M = {}
M.setup = function()
  setup_cmp()
end
return M
