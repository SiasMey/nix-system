local M = {}

---@return TSNode | nil
local function find_cursor_node()
  local node = vim.treesitter.get_node()
  return node
end

---@param start_node TSNode
---@param node_type string
---@return TSNode | nil
local function find_container_node(start_node, node_type)
  ---@type TSNode | nil
  local node = start_node

  while node do
    if node:type() == node_type then return node end
    node = node:parent()
  end

  vim.notify(string.format("No container node of type '%s' found", node_type), vim.log.levels.WARN)
  return nil
end

---@param start_node TSNode
---@return TSNode | nil
local function find_class_container(start_node)
  return find_container_node(start_node, "class_definition")
end

---@param start_node TSNode
---@return TSNode | nil
local function find_function_container(start_node)
  return find_container_node(start_node, "function_definition")
end

---@param start_node TSNode
---@return TSNode | nil
local function find_block_container(start_node)
  return find_container_node(start_node, "block")
end

---@param start_node TSNode
---@return TSNode | nil
local function find_module_container(start_node)
  return find_container_node(start_node, "module")
end

---@param start_node TSNode
---@return TSNode | nil
local function find_call_container(start_node)
  return find_container_node(start_node, "call")
end

---@param node TSNode | nil
local function find_module_imports(node)
  if not node then return nil end
  if node:type() ~= "module" then
    -- todo: list print the unexpected type of the provided node
    vim.notify("Provided node is not a module found: " .. node:type(), vim.log.levels.INFO)
    return nil
  end

  local imports = {}
  local query = vim.treesitter.query.parse("python", "(module [(import_statement) (import_from_statement)] @import)")
  for _, match, _ in query:iter_captures(node, 0) do
    table.insert(imports, match)
  end

  if #imports == 0 then
    vim.notify("No import statements found in the current module", vim.log.levels.WARN)
    return nil
  end

  return imports
end

---@param node TSNode | nil
local function find_module_docstring(node)
  if not node then return nil end
  if node:type() ~= "module" then
    vim.notify("Provided node is not a module", vim.log.levels.WARN)
    return nil
  end

  local query = vim.treesitter.query.parse("python", "(module . (expression_statement (string)) @docstring)")
  for _, match, _ in query:iter_captures(node, 0) do
    return match
  end

  vim.notify("No module docstring found in the current module", vim.log.levels.WARN)
  return nil
end

---@param node TSNode | nil
---@return TSNode[] | nil
local function find_module_functions(node)
  if not node then return nil end
  if node:type() ~= "module" then
    vim.notify("Provided node is not a module", vim.log.levels.WARN)
    return nil
  end

  local functions = {}
  local function_query = vim.treesitter.query.parse("python", "(function_definition name: (identifier) @function_name)")
  for _, function_match, _ in function_query:iter_captures(node, 0) do
    table.insert(functions, function_match)
  end

  if #functions == 0 then
    vim.notify("No functions found in the current module", vim.log.levels.WARN)
    return nil
  end

  return functions
end

---@param node TSNode | nil
local function find_function_docstring(node)
  if not node then return nil end
  if node:type() ~= "function_definition" then
    vim.notify("Provided node is not a function_definition", vim.log.levels.WARN)
    return nil
  end

  local query = vim.treesitter.query.parse(
    "python",
    "(function_definition body: (block .(expression_statement (string)) @docstring))"
  )
  for _, match, _ in query:iter_captures(node, 0) do
    return match
  end

  vim.notify("No function docstring found in the current function", vim.log.levels.WARN)
  return nil
end

---@param node TSNode | nil
---@return TSNode | nil
local function find_function_identifier(node)
  if not node then return nil end
  if node:type() ~= "function_definition" then
    vim.notify("Provided node is not a function_definition", vim.log.levels.WARN)
    return nil
  end

  local query = vim.treesitter.query.parse("python", "(function_definition name: (identifier) @func_name)")
  for _, match, _ in query:iter_captures(node, 0) do
    return match
  end

  vim.notify("No function identifier found in the current function", vim.log.levels.WARN)
  return nil
end

---@param node TSNode | nil
---@return TSNode | nil
local function find_function_parameter_list(node)
  if not node then return nil end
  if node:type() ~= "function_definition" then
    vim.notify("Provided node is not a function_definition", vim.log.levels.WARN)
    return nil
  end

  local query = vim.treesitter.query.parse("python", "(function_definition parameters: (parameters) @params)")
  for _, match, _ in query:iter_captures(node, 0) do
    return match
  end

  vim.notify("No parameter list found in the current function", vim.log.levels.WARN)
  return nil
end

---@param node TSNode | nil
---@return TSNode | nil
local function find_function_body(node)
  if not node then return nil end
  if node:type() ~= "function_definition" then
    vim.notify("Provided node is not a function_definition", vim.log.levels.WARN)
    return nil
  end

  local query = vim.treesitter.query.parse("python", "(function_definition body: (block) @body)")
  for _, match, _ in query:iter_captures(node, 0) do
    return match
  end

  vim.notify("No function body found in the current function", vim.log.levels.WARN)
  return nil
end

---@param node TSNode | nil
local function find_class_docstring(node)
  if not node then return nil end
  if node:type() ~= "class_definition" then
    vim.notify("Provided node is not a class_definition", vim.log.levels.WARN)
    return nil
  end

  local query = vim.treesitter.query.parse(
    "python",
    "(class_definition body: (block . (expression_statement (string)) @docstring))"
  )
  for _, match, _ in query:iter_captures(node, 0) do
    return match
  end

  vim.notify("No class docstring found in the current class", vim.log.levels.WARN)
  return nil
end

local function find_class_init_method(node)
  if not node then return nil end
  if node:type() ~= "class_definition" then
    vim.notify("Provided node is not a class_definition", vim.log.levels.WARN)
    return nil
  end

  local query = vim.treesitter.query.parse(
    "python",
    [[
      (class_definition body:
      (block
      (function_definition name:
      (identifier) @ident (#eq? @ident "__init__")) @func))
    ]]
  )
  for _, match, _ in query:iter_captures(node, 0) do
    if match:type() == "function_definition" then return match end
  end

  vim.notify("No __init__ method found in the current class", vim.log.levels.WARN)
  return nil
end

local function find_class_new_method(node)
  if not node then return nil end
  if node:type() ~= "class_definition" then
    vim.notify("Provided node is not a class_definition", vim.log.levels.WARN)
    return nil
  end

  local query = vim.treesitter.query.parse(
    "python",
    [[
      (class_definition body:
      (block
      (function_definition name:
      (identifier) @ident (#eq? @ident "__new__")) @func))
    ]]
  )
  for _, match, _ in query:iter_captures(node, 0) do
    if match:type() == "function_definition" then return match end
  end

  vim.notify("No __new__ method found in the current class", vim.log.levels.WARN)
  return nil
end

---@param node TSNode | nil
---@return TSNode | nil
local function find_class_identifier(node)
  if not node then return nil end
  if node:type() ~= "class_definition" then
    vim.notify("Provided node is not a class_definition", vim.log.levels.WARN)
    return nil
  end

  local query = vim.treesitter.query.parse("python", "(class_definition name: (identifier) @class_name)")
  for _, match, _ in query:iter_captures(node, 0) do
    return match
  end

  vim.notify("No class identifier found in the current class", vim.log.levels.WARN)
  return nil
end

---@param node TSNode | nil
---@return TSNode[] | nil
local function find_class_methods(node)
  if not node then return nil end
  if node:type() ~= "class_definition" then
    vim.notify("Provided node is not a class_definition", vim.log.levels.WARN)
    return nil
  end

  local methods = {}
  local query = vim.treesitter.query.parse("python", "(class_definition body: (block) @body)")
  for _, match, _ in query:iter_captures(node, 0) do
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

---@param node TSNode | nil
---@return TSNode | nil
local function find_call_argument_list(node)
  if not node then return nil end
  if node:type() ~= "call" then
    vim.notify("Provided node is not a call", vim.log.levels.WARN)
    return nil
  end
  local query = vim.treesitter.query.parse("python", "(call arguments: (argument_list) @args)")
  for _, match, _ in query:iter_captures(node, 0) do
    return match
  end
end

M.find_cursor_node = find_cursor_node

M.find_container_node = find_container_node
M.find_class_container = find_class_container
M.find_function_container = find_function_container
M.find_block_container = find_block_container
M.find_module_container = find_module_container
M.find_call_container = find_call_container

M.find_function_parameter_list = find_function_parameter_list
M.find_function_body = find_function_body
M.find_function_identifier = find_function_identifier
M.find_function_docstring = find_function_docstring

M.find_class_identifier = find_class_identifier
M.find_class_methods = find_class_methods
M.find_class_docstring = find_class_docstring
M.find_class_init_method = find_class_init_method
M.find_class_new_method = find_class_new_method

M.find_module_imports = find_module_imports
M.find_module_docstring = find_module_docstring
M.find_module_functions = find_module_functions

M.find_call_argument_list = find_call_argument_list

return M
