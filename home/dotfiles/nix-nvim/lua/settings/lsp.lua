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
  "pytest_lsp",
  -- "copilot",
  -- "pyrefly",
})

vim.lsp.config("*", {
  root_markers = { ".git", ".jj" },
})

---@param bufnr integer,
---@param client vim.lsp.Client
local function sign_in(bufnr, client)
  client:request(
    ---@diagnostic disable-next-line: param-type-mismatch
    "signIn",
    vim.empty_dict(),
    function(err, result)
      if err then
        vim.notify(err.message, vim.log.levels.ERROR)
        return
      end
      if result.command then
        local code = result.userCode
        local command = result.command
        vim.fn.setreg("+", code)
        vim.fn.setreg("*", code)
        local continue = vim.fn.confirm(
          "Copied your one-time code to clipboard.\n" .. "Open the browser to complete the sign-in process?",
          "&Yes\n&No"
        )
        if continue == 1 then
          client:exec_cmd(command, { bufnr = bufnr }, function(cmd_err, cmd_result)
            if cmd_err then
              vim.notify(cmd_err.message, vim.log.levels.ERROR)
              return
            end
            if cmd_result.status == "OK" then
              vim.notify("Signed in as " .. cmd_result.user .. ".")
            end
          end)
        end
      end

      if result.status == "PromptUserDeviceFlow" then
        vim.notify("Enter your one-time code " .. result.userCode .. " in " .. result.verificationUri)
      elseif result.status == "AlreadySignedIn" then
        vim.notify("Already signed in as " .. result.user .. ".")
      end
    end
  )
end

---@param client vim.lsp.Client
local function sign_out(_, client)
  client:request(
    ---@diagnostic disable-next-line: param-type-mismatch
    "signOut",
    vim.empty_dict(),
    function(err, result)
      if err then
        vim.notify(err.message, vim.log.levels.ERROR)
        return
      end
      if result.status == "NotSignedIn" then
        vim.notify("Not signed in.")
      end
    end
  )
end

vim.lsp.config("copilot", {
  cmd = { "copilot-language-server", "--stdio" },
  root_markers = { ".git", ".jj" },

  init_options = {
    editorInfo = {

      name = "Neovim",
      version = tostring(vim.version()),
    },
    editorPluginInfo = { name = "Neovim", version = tostring(vim.version()) },
  },
  on_attach = function(client, bufnr)
    vim.api.nvim_buf_create_user_command(bufnr, "LspCopilotSignIn", function()
      sign_in(bufnr, client)
    end, { desc = "Sign in Copilot with GitHub" })
    vim.api.nvim_buf_create_user_command(bufnr, "LspCopilotSignOut", function()
      sign_out(bufnr, client)
    end, { desc = "Sign out Copilot with GitHub" })
  end,
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

vim.lsp.config("pytest_lsp", {
  cmd = { "pytest-language-server" },
  filetypes = { "python" },
  root_markers = { "pyproject.toml" },
})

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

vim.lsp.config.pyrefly = {
  filetypes = { "python" },
  root_markers = {
    "pyproject.toml",
  },
  cmd = { "uvx", "pyrefly", "lsp" },
  settings = {
    python = {
      pyrefly = {
        typeCheckingMode = "default",
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
    local bufnr = args.buf

    if client:supports_method("textDocument/inlayHint") or client.server_capabilities.inlayHintProvider then
      vim.keymap.set("n", "<space>i", toggle_inlay)
    else
      vim.keymap.set("n", "<space>i", "<Nop>")
    end

    vim.keymap.set("n", "<space>D", toggle_diagnostics)

    if client:supports_method(vim.lsp.protocol.Methods.textDocument_inlineCompletion, bufnr) then
      vim.lsp.inline_completion.enable(true, { bufnr = bufnr })

      vim.keymap.set(
        "i",
        "<C-F>",
        vim.lsp.inline_completion.get,
        { desc = "LSP: accept inline completion", buffer = bufnr }
      )
      vim.keymap.set(
        "i",
        "<C-G>",
        vim.lsp.inline_completion.select,
        { desc = "LSP: switch inline completion", buffer = bufnr }
      )
    end
  end,
})
