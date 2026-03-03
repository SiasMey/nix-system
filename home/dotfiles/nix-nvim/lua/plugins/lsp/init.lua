local setup_lazydev = function()
  require("lazydev").setup({
    library = {
      -- See the configuration section for more details
      -- Load luvit types when the `vim.uv` word is found
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
    },
  })
end

local function setup_conform()
  require("conform").setup({
    formatters = {
      ruff_fix = {
        command = "uv_ruff",
      },
      ruff_format = {
        command = "uv_ruff",
      },
      ruff_organize_imports = {
        command = "uv_ruff",
      },
    },
    formatters_by_ft = {
      lua = {
        "stylua",
      },
      python = {
        "ruff_fix",
        "ruff_organize_imports",
        "ruff_format",
      },
      go = {
        "golines",
        "goimports",
        "gofumpt",
      },
      nix = { "alejandra" },
      markdown = { "mdformat", "injected" },
      just = { "just" },
      terraform = { "terraform_fmt" },
      toml = { "tombi" },
      sh = { "beautysh" },
      json = { "fixjson", "jq" },
      -- yaml = { "yq" },
    },
    default_format_opts = {
      lsp_format = "fallback",
    },
  })
end

local M = {}
M.setup = function()
  setup_lazydev()
  setup_conform()
end
return M
