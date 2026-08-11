local M = {}

---@param node TSNode | nil
local function highlight_node(node)
  if not node then return end

  local bufnr = vim.api.nvim_get_current_buf()
  local ns_id = vim.api.nvim_create_namespace("ts_utils_highlight")
  local start_row, start_col, end_row, end_col = node:range()
  vim.api.nvim_buf_set_extmark(bufnr, ns_id, start_row, start_col, {
    end_line = end_row,
    end_col = end_col,
    hl_group = "Visual",
  })

  vim.defer_fn(function()
    vim.api.nvim_buf_clear_namespace(bufnr, ns_id, 0, -1)
  end, 200)
end

---@param node TSNode
---@return boolean
local function node_reaches_eof(node)
  local _, _, end_row, _ = node:range()
  return end_row == vim.api.nvim_buf_line_count(0) - 1
end

---@param node_type string
---@return TSNode | nil
local function find_container_node(node_type)
  local node = vim.treesitter.get_node()
  if not node then return nil end

  while node do
    if node:type() == node_type then return node end
    node = node:parent()
  end
end

---@return TSNode | nil
local function find_class_container()
  return find_container_node("class_definition")
end

---@return TSNode | nil
local function find_function_container()
  return find_container_node("function_definition")
end

---@return TSNode | nil
local function find_block_container()
  return find_container_node("block")
end

---@return TSNode | nil
local function find_function_parameter_list()
  local node = find_function_container()
  if not node then
    vim.notify("No parent function_definition", vim.log.levels.WARN)
    return nil
  end

  local query = vim.treesitter.query.parse("python", "(function_definition parameters: (parameters) @params)")
  for _, match, _ in query:iter_captures(node, 0) do
    return match
  end

  vim.notify("No parameter list found in the current function", vim.log.levels.WARN)
  return nil
end

---@return TSNode | nil
local function find_function_body()
  local node = find_function_container()
  if not node then
    vim.notify("No parent function_definition", vim.log.levels.WARN)
    return nil
  end

  local query = vim.treesitter.query.parse("python", "(function_definition body: (block) @body)")
  for _, match, _ in query:iter_captures(node, 0) do
    return match
  end

  vim.notify("No function body found in the current function", vim.log.levels.WARN)
  return nil
end

---@return TSNode | nil
local function move_cursor_node_end(node)
  if not node then return end
  vim.cmd("normal! m`")
  local _, _, end_row, end_col = node:range()
  -- this moves cursor to -1 of node end, good for in node edit, bad for after node edit
  vim.api.nvim_win_set_cursor(0, { end_row + 1, end_col - 1 })
end

---@return TSNode | nil
local function move_cursor_node_start(node)
  if not node then return end
  vim.cmd("normal! m`")
  local start_row, start_col, _, _ = node:range()
  -- this moves cursor to -1 of node end, good for in node edit, bad for after node edit
  vim.api.nvim_win_set_cursor(0, { start_row + 1, start_col })
end

---@return TSNode | nil
local function find_container_function_identifier()
  local func_node = find_function_container()
  if not func_node then return nil end

  local query = vim.treesitter.query.parse("python", "(function_definition name: (identifier) @func_name)")
  for _, match, _ in query:iter_captures(func_node, 0) do
    return match
  end

  vim.notify("No function name found in the current function", vim.log.levels.WARN)
  return nil
end

---#return TSNode | nil
local function find_container_class_identifier()
  local class_node = find_class_container()
  if not class_node then return nil end

  local query = vim.treesitter.query.parse("python", "(class_definition name: (identifier) @class_name)")
  for _, match, _ in query:iter_captures(class_node, 0) do
    return match
  end

  vim.notify("No class name found in the current class", vim.log.levels.WARN)
  return nil
end

local function find_container_class_methods()
  local class_node = find_class_container()
  if not class_node then
    vim.notify("No parent class_definition", vim.log.levels.WARN)
    return nil
  end

  local methods = {}
  local query = vim.treesitter.query.parse("python", "(class_definition body: (block) @body)")
  for _, match, _ in query:iter_captures(class_node, 0) do
    local method_query = vim.treesitter.query.parse("python", "(function_definition name: (identifier) @method_name)")
    for _, method_match, _ in method_query:iter_captures(match, 0) do
      table.insert(methods, method_match)
    end
  end

  if #methods == 0 then
    vim.notify("No methods found in the current class", vim.log.levels.WARN)
    return nil
  end

  return methods
end

local function jump_function_name()
  local func_node = find_function_container()
  if not func_node then return end

  local query = vim.treesitter.query.parse("python", "(function_definition name: (identifier) @func_name)")
  for _, match, _ in query:iter_captures(func_node, 0) do
    move_cursor_node_start(match)
    return
  end

  vim.notify("No function name found in the current function", vim.log.levels.WARN)
end

local function jump_class_name()
  local class_node = find_class_container()
  if not class_node then return end

  local query = vim.treesitter.query.parse("python", "(class_definition name: (identifier) @class_name)")
  for _, match, _ in query:iter_captures(class_node, 0) do
    move_cursor_node_start(match)
    return
  end

  vim.notify("No class name found in the current class", vim.log.levels.WARN)
end

local function update_function_parameters()
  local param_list = find_function_parameter_list()
  if not param_list then return end

  move_cursor_node_end(param_list)
  -- vim.cmd.startinsert()
end

local function update_return_type_annotation()
  local func_node = find_function_container()
  if not func_node then return end

  local query = vim.treesitter.query.parse("python", "(function_definition return_type: (type) @return_type)")
  for _, match, _ in query:iter_captures(func_node, 0) do
    move_cursor_node_start(match)
    return
  end

  -- If no return type annotation exists, insert one
  local param_list = find_function_parameter_list()
  if not param_list then return end

  local _, _, end_row, end_col = param_list:range()
  vim.api.nvim_buf_set_text(0, end_row, end_col, end_row, end_col, { " -> " })
  vim.cmd("normal! m`")
  vim.api.nvim_win_set_cursor(0, { end_row + 1, end_col + 4 })
  -- vim.cmd.startinsert()
end

local function insert_new_test()
  local class_node = find_class_container()
  if not class_node then return end

  local query = vim.treesitter.query.parse("python", "(class_definition body: (block) @body)")
  for _, match, _ in query:iter_captures(class_node, 0) do
    if node_reaches_eof(match) then
      vim.api.nvim_buf_set_lines(0, -1, -1, false, { "", "    " })
      vim.api.nvim_win_set_cursor(0, { vim.api.nvim_buf_line_count(0), 5 })
    else
      local _, _, end_row, _ = match:range()
      vim.api.nvim_buf_set_lines(0, end_row + 1, end_row + 1, false, { "", "    " })
      vim.api.nvim_win_set_cursor(0, { end_row + 3, 5 })
    end
  end
  vim.api.nvim_feedkeys("adt", "n", false)
end

local function insert_new_function()
  local class_node = find_class_container()
  if not class_node then return end

  local query = vim.treesitter.query.parse("python", "(class_definition body: (block) @body)")
  for _, match, _ in query:iter_captures(class_node, 0) do
    if node_reaches_eof(match) then
      vim.api.nvim_buf_set_lines(0, -1, -1, false, { "", "    " })
      vim.api.nvim_win_set_cursor(0, { vim.api.nvim_buf_line_count(0), 5 })
    else
      local _, _, end_row, _ = match:range()
      vim.api.nvim_buf_set_lines(0, end_row + 1, end_row + 1, false, { "", "    " })
      vim.api.nvim_win_set_cursor(0, { end_row + 3, 5 })
    end
  end
  vim.api.nvim_feedkeys("adf", "n", false)
end

local function insert_new_test_class()
  vim.api.nvim_buf_set_lines(0, -1, -1, false, { "", "" })
  vim.api.nvim_win_set_cursor(0, { vim.api.nvim_buf_line_count(0), 3 })
  vim.api.nvim_feedkeys("act", "n", false)
end

local function insert_new_statement()
  local body_node = find_function_body()
  if not body_node then return end

  move_cursor_node_end(body_node)
  vim.api.nvim_feedkeys("o", "n", false)
end

M.highlight_node = highlight_node

M.move_cursor_node_end = move_cursor_node_end
M.find_class_container = find_class_container
M.find_function_container = find_function_container
M.find_function_parameter_list = find_function_parameter_list
M.find_function_body = find_function_body
M.find_class_methods = find_container_class_methods

M.insert_new_test = insert_new_test
M.insert_new_function = insert_new_function
M.insert_new_statement = insert_new_statement
M.insert_new_test_class = insert_new_test_class
M.update_return_type_annotation = update_return_type_annotation

M.update_function_parameters = update_function_parameters
M.jump_function_name = jump_function_name
M.jump_class_name = jump_class_name

local nl = require("ts-utils.node_locator")
local cm = require("ts-utils.cursor_mover")

vim.keymap.set({ "n", "v" }, "f", "<Nop>", { desc = "Prefix for ts-utils" })
vim.keymap.set({ "n", "v" }, "t", "<Nop>", { desc = "Prefix for ts-utils" })
vim.keymap.set({ "n", "v" }, "s", "<Nop>", { desc = "Prefix for ts-utils" })

vim.keymap.set("n", "ttc", M.insert_new_test_class, { desc = "Insert new test class" })

vim.keymap.set("n", "fis", M.insert_new_statement, { desc = "Insert new statement in function body" })
vim.keymap.set("n", "frt", M.update_return_type_annotation, { desc = "Insert or update return type annotation" })
vim.keymap.set("n", "fp", M.update_function_parameters, { desc = "Insert at end of parameters" })
vim.keymap.set("n", "fci", M.jump_class_name, { desc = "Jump to start of class name" })
vim.keymap.set("n", "ffi", M.jump_function_name, { desc = "Jump to start of function name" })

-- I want some new text-objects
-- c,d,y for
-- ia inside argument list
-- "pair" key, value delimited by ":"
-- assignment target, expression pair delimited by "="

-- overload for keymaps for move "in" and "out"
-- so that they move in lists, arguments and parameters

vim.keymap.set("n", "fia", function()
  local cursor_node = nl.find_cursor_node()
  if not cursor_node then return end
  cm.move_cursor_node_start(nl.find_call_argument_list(nl.find_call_container(cursor_node)))
end)

vim.keymap.set("n", "fns", function()
  local cursor_node = nl.find_cursor_node()
  if not cursor_node then return end
  highlight_node(cursor_node)
  -- todo check if node start is "container" character like )]}> and if so place cursor after it
  cm.move_cursor_node_start(cursor_node)
  -- vim.api.nvim_feedkeys("a", "n", false)
end)

vim.keymap.set("n", "fne", function()
  local cursor_node = nl.find_cursor_node()
  if not cursor_node then return end
  highlight_node(cursor_node)
  -- todo check if node end is "container" character like )]}> and if so place cursor before it
  cm.move_cursor_node_end(cursor_node)
  -- vim.api.nvim_feedkeys("i", "n", false)
end)

local keymaps = require("ts-utils.keymaps")
keymaps.setup()
local difftastic = require("ts-utils.difftastic")
difftastic.setup()
local _ = require("ts-utils.search")

return M
