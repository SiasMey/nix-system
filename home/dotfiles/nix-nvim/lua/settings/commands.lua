vim.api.nvim_create_user_command("ClearQF", function(opts)
  _ = opts
  vim.cmd.call("setqflist([], 'r')")
end, {})
