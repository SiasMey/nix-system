vim.api.nvim_create_user_command("Note", function(opts)
  _ = opts
  local output = vim.fn.system("ztr create")
  vim.cmd.edit(output)
end, {})
vim.api.nvim_create_user_command("ClearQF", function(opts)
  _ = opts
  vim.cmd.call("setqflist([], 'r')")
end, {})
vim.api.nvim_create_user_command("TmuxTest", function(opts)
  _ = opts
  _ = vim.fn.system("tmux-test")
end, {})
vim.api.nvim_create_user_command("Gw", function(opts)
  _ = opts
  vim.cmd.w()
  vim.cmd("silent !git add %")
end, {})
vim.api.nvim_create_user_command("Gc", function(opts)
  _ = opts
  vim.cmd('!tmux display-popup -E -d $(pwd) "git commit"')
end, {})
