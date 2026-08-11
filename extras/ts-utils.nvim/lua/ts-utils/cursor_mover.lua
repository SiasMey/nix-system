local M = {}

---@param node TSNode
---@return boolean
local function node_reaches_eof(node)
  local _, _, end_row, _ = node:range()
  return end_row == vim.api.nvim_buf_line_count(0) - 1
end

---@return TSNode | nil
local function move_cursor_node_end(node)
  if not node then return end
  vim.cmd("normal! m`")
  local _, _, end_row, end_col = node:range()

  vim.notify("node end {" .. end_row .. ", " .. end_col .. "}", vim.log.levels.INFO)

  if end_row >= vim.api.nvim_buf_line_count(0) - 1 then
    vim.api.nvim_win_set_cursor(0, { vim.api.nvim_buf_line_count(0), 0 })
  else
    vim.api.nvim_win_set_cursor(0, { end_row + 1, end_col })
  end
end

---@return TSNode | nil
local function move_cursor_node_start(node)
  if not node then return end
  vim.cmd("normal! m`")
  local start_row, start_col, _, _ = node:range()

  vim.api.nvim_win_set_cursor(0, { start_row + 1, start_col })
end

M.move_cursor_node_start = move_cursor_node_start
M.move_cursor_node_end = move_cursor_node_end
M.node_reaches_eof = node_reaches_eof

return M
