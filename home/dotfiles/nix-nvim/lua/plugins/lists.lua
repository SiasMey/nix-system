local toggle_qf = function()
  local qf_exists = false
  for _, win in pairs(vim.fn.getwininfo()) do
    if win["quickfix"] == 1 then
      qf_exists = true
    end
  end
  if qf_exists == true then
    vim.cmd("cclose")
    return
  end
  if not vim.tbl_isempty(vim.fn.getqflist()) then
    vim.cmd("copen")
  end
end

local toggle_loclist = function()
  local loc_exists = false
  for _, win in pairs(vim.fn.getwininfo()) do
    if win["loclist"] == 1 then
      loc_exists = true
    end
  end
  if loc_exists == true then
    vim.cmd("lclose")
    return
  end
  if not vim.tbl_isempty(vim.fn.getloclist(0)) then
    vim.cmd("lopen")
  end
end

local M = {}
M.setup = function()
  vim.keymap.set("n", "<leader>q", toggle_qf, { desc = "Toggle QF" })
  vim.keymap.set("n", "<leader>l", toggle_loclist, { desc = "Toggle LocList" })
end
return M
