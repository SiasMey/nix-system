local M = {}

local function rg_json_search(query)
  -- Run ripgrep with json formatting
  vim.system({ "rg", "--json", query, "." }, { text = true }, function(obj)
    if obj.code ~= 0 then return end

    local qf_items = {}

    -- Parse JSON lines from the ripgrep output
    for line in string.gmatch(obj.stdout, "[^\r\n]+") do
      local ok, decoded = pcall(vim.json.decode, line)
      if ok and decoded.type == "match" then
        local match = decoded.data

        -- Create a valid Quickfix list item
        table.insert(qf_items, {
          filename = match.path.text,
          lnum = match.line_number,
          col = match.submatches[1].start + 1,
          text = match.lines.text,
        })
      end
    end

    -- Update quickfix list safely from the main event loop
    vim.schedule(function()
      vim.fn.setqflist(qf_items, "r")
      vim.cmd("copen")
    end)
  end)
end

local function rg_search_current(query)
  -- Run ripgrep with json formatting
  local current_file = vim.fn.expand("%:p")

  vim.system({ "rg", "--json", query, current_file }, { text = true }, function(obj)
    if obj.code ~= 0 then return end

    local loc_items = {}

    -- Parse JSON lines from the ripgrep output
    for line in string.gmatch(obj.stdout, "[^\r\n]+") do
      local ok, decoded = pcall(vim.json.decode, line)
      if ok and decoded.type == "match" then
        local match = decoded.data

        -- Create a valid Quickfix list item
        table.insert(loc_items, {
          filename = match.path.text,
          lnum = match.line_number,
          col = match.submatches[1].start + 1,
          text = match.lines.text,
        })
      end
    end

    -- Update quickfix list safely from the main event loop
    vim.schedule(function()
      vim.fn.setloclist(0, loc_items, "r")
      vim.cmd("lopen")
    end)
  end)
end

local function remove_loclist_item()
  local locl_list = vim.fn.getloclist(0)
  local current_line = vim.fn.line(".")

  if locl_list[current_line] then
    table.remove(locl_list, current_line)
    vim.fn.setloclist(0, locl_list, "r")
    vim.fn.cursor(math.min(current_line, #locl_list), 1)
  end
end

local function remove_quickfix_item()
  local qf_list = vim.fn.getqflist()
  local current_line = vim.fn.line(".")

  if qf_list[current_line] then
    table.remove(qf_list, current_line)
    vim.fn.setqflist(qf_list, "r")

    -- Keep the cursor at the same position
    vim.fn.cursor(current_line, 1)
  end
end

local function safe_cnext()
  local ok = pcall(vim.cmd.cnext)
  if not ok then
    pcall(vim.cmd.cfirst)
  end
end

local function safe_cprev()
  local ok = pcall(vim.cmd.cprev)
  if not ok then
    pcall(vim.cmd.clast)
  end
end

local function safe_lnext()
  local ok = pcall(vim.cmd.lnext)
  if not ok then
    pcall(vim.cmd.lfirst)
  end
end

local function safe_lprev()
  local ok = pcall(vim.cmd.lprev)
  if not ok then
    pcall(vim.cmd.llast)
  end
end


vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  callback = function()
    -- Delete single item under cursor with dd
    vim.keymap.set("n", "dd", function()
      local is_loclist = vim.fn.getwininfo(vim.fn.win_getid())[1].loclist == 1
      if is_loclist then
        remove_loclist_item()
      else
        remove_quickfix_item()
      end
    end, { buffer = true, silent = true, desc = "Remove quickfix item" })
  end,
})

vim.keymap.set("n", "<M-l>", safe_cprev)
vim.keymap.set("n", "<M-h>", safe_cnext)

vim.keymap.set("n", "<M-j>", safe_lprev)
vim.keymap.set("n", "<M-k>", safe_lnext)

M.rg_json_search = rg_json_search
M.rg_search_current = rg_search_current

return M
