local nl = require("ts-utils.node_locator")
local cm = require("ts-utils.cursor_mover")

local function jump_back_to_prev()
  local bufnr = vim.api.nvim_get_current_buf()
  vim.api.nvim_create_autocmd("InsertLeave", {
    buffer = bufnr,
    once = true,
    callback = function()
      -- this is not actually working for some reason
      vim.cmd("normal! <C-o>")
    end,
  })
end

local insert_module_import = function()
  local node = nl.find_cursor_node()
  if not node then return end

  local container = nl.find_module_container(node)
  if not container then return end

  local imports = nl.find_module_imports(container)
  if not imports then
    -- if there are no imports, jump to the start of the module and insert a new import statement
    cm.move_cursor_node_start(container)
    vim.api.nvim_feedkeys("o", "n", false)
    return
  end

  local last = imports[#imports]
  cm.move_cursor_node_end(last)

  -- jump_back_to_prev()
  vim.api.nvim_feedkeys("o", "n", false)
end

local visual_class_identifier = function()
  local node = nl.find_cursor_node()
  if not node then return end

  local container = nl.find_class_container(node)
  if not container then return end

  local identifier = nl.find_class_identifier(container)
  if not identifier then return end

  cm.move_cursor_node_start(identifier)
  vim.cmd("normal! v")
  cm.move_cursor_node_end(identifier)
end

local visual_function_identifier = function()
  local node = nl.find_cursor_node()
  if not node then return end

  local container = nl.find_function_container(node)
  if not container then return end

  local identifier = nl.find_function_identifier(container)
  if not identifier then return end

  cm.move_cursor_node_start(identifier)
  vim.cmd("normal! v")
  cm.move_cursor_node_end(identifier)
end

local visual_test_identifier = function() end

local visual_given_identifier = function() end

local move_in = function()
  local cursor_node = nl.find_cursor_node()
  if not cursor_node then
    require("treewalker").move_in()
    return
  end

  local assignment = nl.find_container_node(cursor_node, "assignment")
  if not assignment then
    require("treewalker").move_in()
    return
  end

  local right = assignment:field("right")[1]
  if cursor_node:id() == right:id() then
    require("treewalker").move_in()
    return
  end

  cm.move_cursor_node_start(right)
end

local move_out = function()
  local cursor_node = nl.find_cursor_node()
  if not cursor_node then
    require("treewalker").move_out()
    return
  end

  local assignment = nl.find_container_node(cursor_node, "assignment")
  if not assignment then
    require("treewalker").move_out()
    return
  end

  local left = assignment:field("left")[1]
  if cursor_node:id() == left:id() then
    require("treewalker").move_out()
    return
  end

  cm.move_cursor_node_start(left)
end

local insert_test_function = function()
  local cursor_node = nl.find_cursor_node()
  if not cursor_node then return end

  local class = nl.find_class_container(cursor_node)

  if class then
    local _, _, end_row, _ = class:range()
    if cm.node_reaches_eof(class) then
      vim.api.nvim_buf_set_lines(0, -1, -1, false, { "", "    " })
      vim.api.nvim_win_set_cursor(0, { vim.api.nvim_buf_line_count(0), 5 })
    else
      vim.api.nvim_buf_set_lines(0, end_row + 1, end_row + 1, false, { "", "    " })
      vim.api.nvim_win_set_cursor(0, { end_row + 3, 5 })
    end
  else
    vim.api.nvim_buf_set_lines(0, -1, -1, false, { "", "" })
    vim.api.nvim_win_set_cursor(0, { vim.api.nvim_buf_line_count(0), 0 })
  end

  vim.api.nvim_feedkeys("adt", "n", false)
end

local insert_function = function()
  local cursor_node = nl.find_cursor_node()
  if not cursor_node then return end

  local class = nl.find_class_container(cursor_node)

  if class then
    local _, _, end_row, _ = class:range()
    if cm.node_reaches_eof(class) then
      vim.api.nvim_buf_set_lines(0, -1, -1, false, { "", "    " })
      vim.api.nvim_win_set_cursor(0, { vim.api.nvim_buf_line_count(0), 5 })
    else
      vim.api.nvim_buf_set_lines(0, end_row + 1, end_row + 1, false, { "", "    " })
      vim.api.nvim_win_set_cursor(0, { end_row + 3, 5 })
    end
  else
    vim.api.nvim_buf_set_lines(0, -1, -1, false, { "", "" })
    vim.api.nvim_win_set_cursor(0, { vim.api.nvim_buf_line_count(0), 0 })
  end

  vim.api.nvim_feedkeys("adf", "n", false)
end

local M = {}
M.setup = function()
  vim.keymap.set("n", "tmi", insert_module_import, { desc = "Add a module import" })

  vim.keymap.set("n", "ttf", insert_test_function, { desc = "Add a test function" })
  vim.keymap.set("n", "tf", insert_function, { desc = "Add a function" })

  vim.keymap.set({ "o", "x" }, "ci", visual_class_identifier, { desc = "Class identifier text object" })
  vim.keymap.set({ "o", "x" }, "fi", visual_function_identifier, { desc = "Function identifier text object" })
  vim.keymap.set({ "o", "x" }, "ti", visual_test_identifier, { desc = "Test identifier text object" })
  vim.keymap.set({ "o", "x" }, "gi", visual_given_identifier, { desc = "Test identifier text object" })
  vim.keymap.set({ "n", "x", "o" }, "m", move_out)
  vim.keymap.set({ "n", "x", "o" }, "n", move_in)
end
return M
