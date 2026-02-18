vim.lsp.enable({
  "luals",
  "nix",
  "spelling",
  "writing",
  "basedpyright",
  "ruff",
  "rust_analyzer",
  "gopls",
  "ast_grep",
  "tombi",
  "ty",
  "nu",
})

vim.lsp.config("*", {
  root_markers = { ".git", ".jj" },
})

vim.lsp.config.luals = {
  filetypes = { "lua" },
  root_markers = {
    ".luarc.json",
    ".luarc.jsonc",
    ".luacheckrc",
    ".stylua.toml",
    "stylua.toml",
    "selene.toml",
    "selene.yml",
    ".git",
    ".jj",
  },
  cmd = { "lua-language-server" },
  settings = {
    Lua = {
      workspace = {
        checkThirdParty = false,
        library = vim.api.nvim_get_runtime_file("", true),
      },
      completion = {
        callSnippet = "Replace",
      },
    },
  },
}

vim.lsp.config.nix = {
  filetypes = { "nix" },
  root_markers = { "flake.nix", ".git" },
  cmd = { "nixd" },
  settings = {
    nixd = {
      nixpkgs = {
        expr = "import <nixpkgs> { }",
      },
      options = {
        nixos = {
          expr = '(builtins.getFlake ("git+file://" + toString ./.)).nixosConfigurations.foot3.options',
        },
        home_manager = {
          expr = '(builtins.getFlake ("git+file://" + toString ./.)).homeConfigurations."siasm@foot3".options',
        },
      },
      formatting = {
        command = { "alejandra" },
      },
    },
  },
}

vim.lsp.config.spelling = {
  root_markers = { "typos.toml", ".typos.toml", "_types.toml" },
  cmd = { "typos-lsp" },
  init_options = {
    config = "~/.config/typos/typos.toml",
    diagnosticSeverity = "Error",
  },
}

vim.lsp.config.basedpyright = {
  filetypes = { "python" },
  root_markers = {
    "pyproject.toml",
    "pyrightconfig.json",
  },
  cmd = { "uv", "run", "basedpyright-langserver", "--stdio" },
  settings = {
    basedpyright = {
      disableOrganizeImports = true,
      disableLanguageServices = true,
      analysis = {
        autoImportCompletions = false,
        useLibraryCodeForTypes = false,
      },
    },
  },
}

vim.lsp.config.ruff = {
  filetypes = { "python" },
  root_markers = {
    "pyproject.toml",
    "ruff.toml",
  },
  cmd = { "uv", "run", "ruff", "server" },
  settings = {},
}

vim.lsp.config.ty = {
  filetypes = { "python" },
  root_markers = {
    "pyproject.toml",
  },
  cmd = { "uvx", "ty", "server" },
  settings = {
    python = {
      ty = {
        -- disableLanguageServices = true,
      },
    },
  },
}

vim.lsp.config.ast_grep = {
  filetypes = { "python", "go", "rust" },
  root_markers = {
    "sgconfig.yml",
  },
  cmd = { "ast-grep", "lsp" },
}

vim.lsp.config.rust_analyzer = {
  filetypes = { "rust" },
  root_markers = { "Cargo.toml" },
  cmd = { "rust-analyzer" },
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        allFeatures = true,
        loadOutDirsFromCheck = true,
        runBuildScripts = true,
      },
      -- Add clippy lints for Rust.
      checkOnSave = true,
      check = {
        allFeatures = true,
        command = "clippy",
        extraArgs = {
          "--",
          "--no-deps",
          "-Dclippy::correctness",
          "-Dclippy::complexity",
          "-Wclippy::suspicious",
          "-Wclippy::perf",
          "-Wclippy::pedantic",
          "-Wclippy::style",
        },
      },
      procMacro = {
        enable = true,
        ignored = {
          ["async-trait"] = { "async_trait" },
          ["napi-derive"] = { "napi" },
          ["async-recursion"] = { "async_recursion" },
        },
      },
    },
  },
}

vim.lsp.config.nu = {
  filetypes = { "nu" },
  cmd = { "nu", "--lsp" },
}

vim.lsp.config.gopls = {
  filetypes = { "go" },
  cmd = { "gopls" },
  root_markers = { "go.mod" },
}

vim.lsp.config.writing = {
  filetypes = { "markdown", "text", "tex", "rst" },
  root_markers = { ".vale.ini" },
  cmd = { "vale-ls" },
  settings = {},
}

vim.lsp.config.yamlls = {
  cmd = { "yaml-language-server", "--stdio" },
  filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab" },
  settings = {
    yaml = {
      keyOrdering = true,
    },
  },
}

vim.lsp.config.tombi = {
  cmd = { "uvx", "tombi", "lsp" },
  filetypes = { "toml" },
  root_markers = { "tombi.toml", "cargo.toml", "pyproject.toml", ".git", ".jj" },
}

local function toggle_diagnostics()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled({ bufnr = 0 }), { bufnr = 0 })
end

local function toggle_inlay()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = 0 }), { bufnr = 0 })
end

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("my.lsp", {}),
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

    if client:supports_method("textDocument/inlayHint") or client.server_capabilities.inlayHintProvider then
      vim.keymap.set("n", "<space>i", toggle_inlay)
    else
      vim.keymap.set("n", "<space>i", "<Nop>")
    end

    vim.keymap.set("n", "<space>D", toggle_diagnostics)
  end,
})
