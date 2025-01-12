local function augroup(name)
  return vim.api.nvim_create_augroup("nix-nvim" .. name, { clear = true })
end

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = augroup("checktime"),
  command = "checktime",
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
  group = augroup("resize_splits"),
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("close_with_q"),
  pattern = {
    "qf",
    "help",
    "neotest-summary",
    "neotest-output",
    "fugitive",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("wrap_spell"),
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup("gitcommit_keybinds"),
  pattern = { "gitcommit" },
  callback = function(event)
    vim.keymap.set("i", "<C-n>", "<cmd>q!<cr>", { buffer = event.buf, silent = true })
    vim.keymap.set("i", "<C-y>", "<cmd>wq<cr>", { buffer = event.buf, silent = true })
    vim.keymap.set("n", "q", "<cmd>q!<cr>", { buffer = event.buf, silent = true })
    vim.keymap.set("n", "<C-n>", "<cmd>q!<cr>", { buffer = event.buf, silent = true })
    vim.keymap.set("n", "<C-y>", "<cmd>wq<cr>", { buffer = event.buf, silent = true })
  end,
})

vim.api.nvim_create_autocmd("ColorScheme", {
  group = augroup("colorscheme"),
  callback = function()
    -- if vim.g.colors_name == "NeoSolarized" then
    vim.api.nvim_set_hl(0, "LeapBackdrop", { link = "Comment" })
    vim.api.nvim_set_hl(0, "LeapMatch", { fg = "magenta", bold = true, italic = true, nocombine = true })
    vim.api.nvim_set_hl(0, "LeapLabel", { fg = "red", bold = true, italic = true, nocombine = true })
    -- end
  end,
})
