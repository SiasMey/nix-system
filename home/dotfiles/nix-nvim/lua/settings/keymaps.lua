vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>p", '"+p')
-- vim.keymap.set("n", "<leader>s", "<c-^>")
vim.keymap.set("n", "Y", "y$")

vim.keymap.set("n", "l", "<Nop>")
vim.keymap.set("n", "h", "<Nop>")
vim.keymap.set("n", "<c-c>", "<Nop>")
vim.keymap.set("c", "<c-h>", "<Nop>")
vim.keymap.set("n", "<c-l>", "<Nop>")
vim.keymap.set("n", "<c-h>", "<Nop>")
vim.keymap.set("i", "<c-l>", "<Nop>")
vim.keymap.set("i", "<c-h>", "<Nop>")
vim.keymap.set("i", "<c-n>", "<Nop>")

vim.keymap.set("i", "<c-l>", "<c-p>")
vim.keymap.set("i", "<c-h>", "<c-n>")
vim.keymap.set("i", "<c-n>", "<c-x>")

-- Marks
vim.keymap.set("n", "M", "<Nop>")
vim.keymap.set("n", "m", "<Nop>")

vim.keymap.set("c", "<c-y>", "<c-m>")

-- navigation
vim.keymap.set("n", "<c-d>", "<Nop>")
vim.keymap.set("n", "<c-u>", "<Nop>")

vim.keymap.set("n", "j", "<c-u>")
vim.keymap.set("n", "k", "<c-d>")

vim.keymap.set("n", "l", "k^")
vim.keymap.set("n", "h", "j^")

vim.keymap.set("v", "j", "<Nop>")
vim.keymap.set("v", "k", "<Nop>")
vim.keymap.set("v", "<c-d>", "<Nop>")
vim.keymap.set("v", "<c-u>", "<Nop>")
vim.keymap.set("v", "<c-j>", "<c-u>")
vim.keymap.set("v", "<c-k>", "<c-d>")
vim.keymap.set("v", "l", "k")
vim.keymap.set("v", "h", "j")

vim.keymap.set("n", "<leader>xt", ":!chmod +x %<Enter>")

vim.keymap.set("n", "<space>b", ":silent make %<Enter>")
vim.keymap.set("n", "<space>p", ":silent make .<Enter>")
-- vim.keymap.set("n", "<space>tt", ":silent TmuxTest<Enter>")

vim.keymap.set("n", "<M-j>", ":silent cprev<Enter>")
vim.keymap.set("n", "<M-k>", ":silent cnext<Enter>")

vim.keymap.set("o", "i_", ":<c-u>silent! normal! t_T_vt_<cr>", { desc = "Inside _" })
vim.keymap.set("o", "a_", ":<c-u>silent! normal! f_F_vf_<cr>", { desc = "Around _" })
vim.keymap.set("o", "i-", ":<c-u>silent! normal! t-T-vt-<cr>", { desc = "Inside -" })
vim.keymap.set("o", "a-", ":<c-u>silent! normal! f-F-vf-<cr>", { desc = "Around -" })

vim.keymap.set("o", "il", ":<c-u>silent! normal! $v^<cr>", { desc = "Inside current line" })
vim.keymap.set("o", "al", ":<c-u>silent! normal! $v0<cr>", { desc = "Around current line" })
vim.keymap.set("x", "il", ":<c-u>silent! normal! $v^<cr>", { desc = "Inside current line" })
vim.keymap.set("x", "al", ":<c-u>silent! normal! $v0<cr>", { desc = "Around current line" })

vim.keymap.set("n", "w", "", { desc = "unset" })
vim.keymap.set("n", "b", "", { desc = "unset" })

vim.keymap.set("v", "<C-M-w>", ":move'<-2<CR>==gv", { desc = "move selection up" })
vim.keymap.set("v", "<C-M-x>", ":move'>+1<CR>==gv", { desc = "move selection down" })

vim.keymap.set("n", "<M-l>", function()
  print("goto prev diagnostic")
  vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "goto previous diagnostic in buffer" })
vim.keymap.set("n", "<M-h>", function()
  print("goto next diagnostic")
  vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "goto next diagnostic in buffer" })

vim.keymap.set("n", "<space>d", vim.diagnostic.open_float)
vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "gr", vim.lsp.buf.references)
vim.keymap.set("n", "gD", vim.lsp.buf.declaration)
vim.keymap.set("n", "gi", vim.lsp.buf.implementation)
vim.keymap.set("n", "gt", vim.lsp.buf.type_definition)
vim.keymap.set("n", "<c-m>", vim.lsp.buf.hover)
vim.keymap.set({ "n", "i" }, "<c-e>", vim.lsp.buf.signature_help)
vim.keymap.set({ "n", "v" }, "<space>c", vim.lsp.buf.code_action)
vim.keymap.set({ "n", "v" }, "<space>f", function()
  require("conform").format({})
end)
vim.keymap.set("n", "<space>n", vim.lsp.buf.rename)

local function jj_commit_desc()
  vim.ui.input({ prompt = "Update commit desc > " }, function(input)
    if input then
      vim.cmd("!jj desc -m '" .. input .. "'")
    end
  end)
end

local function jj_commit_new()
  vim.ui.input({ prompt = "New commit > " }, function(input)
    if input then
      vim.cmd("!jj new -m '" .. input .. "'")
    end
  end)
end

local function jj_status()
  vim.cmd('silent !tmux display-popup -d "\\#{pane_current_path}" jj')
end

vim.keymap.set("n", "<space>cd", jj_commit_desc)
vim.keymap.set("n", "<space>cn", jj_commit_new)
vim.keymap.set("n", "<space>cs", jj_status)

vim.keymap.set("n", "<space>tm", function()
  require("neotest").summary.run_marked()
end)
vim.keymap.set("n", "<space>tt", function()
  require("neotest").run.run(vim.fn.expand("%"))
end)
vim.keymap.set("n", "<space>ts", function()
  require("neotest").summary.toggle()
end)
vim.keymap.set("n", "<space>to", function()
  require("neotest").output_panel.toggle()
end)

vim.keymap.set({ "n", "x", "o" }, "<m-p>", function()
  require("treewalker").move_up()
end)
vim.keymap.set({ "n", "x", "o" }, "<m-d>", function()
  require("treewalker").move_down()
end)
vim.keymap.set({ "n", "x", "o" }, "<m-t>", function()
  require("treewalker").move_out()
end)
vim.keymap.set({ "n", "x", "o" }, "<m-g>", function()
  require("treewalker").move_in()
end)
vim.keymap.set("n", "<m-c-d>", function()
  require("treewalker").swap_down()
end)
vim.keymap.set("n", "<m-c-p>", function()
  require("treewalker").swap_up()
end)
vim.keymap.set("n", "<m-c-t>", function()
  require("treewalker").swap_left()
end)
vim.keymap.set("n", "<m-c-g>", function()
  require("treewalker").swap_right()
end)
