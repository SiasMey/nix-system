local M = {}
M.setup = function()
  require("neotest").setup({
    adapters = {
      require("neotest-python")({
        dap = { justMyCode = false },
      }),
    },
  })
  require("approval").setup({
    pytest_cmd = "uv-pytest", -- pytest executable
    pytest_args = { "-v", "--tb=short" }, -- default pytest arguments
    inject_reporter_plugin = true, -- auto-suppress external diff tools
    keymaps = {
      run_nearest = "<leader>tn",
      run_file = "<leader>tf",
      next_failure = "]a",
      prev_failure = "[a",
    },
  })
end
return M
