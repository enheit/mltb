-- Theme selector with clean UI
local M = {}

local state = {
  buf = nil,
  win = nil,
  current_index = 1,
  items = {},
  callback = nil,
}

-- Render the list
local function render()
  if not state.buf or not vim.api.nvim_buf_is_valid(state.buf) then
    return
  end

  local lines = {}
  for i, item in ipairs(state.items) do
    table.insert(lines, "  " .. item.label)
  end

  vim.api.nvim_buf_set_option(state.buf, 'modifiable', true)
  vim.api.nvim_buf_set_lines(state.buf, 0, -1, false, lines)
  vim.api.nvim_buf_set_option(state.buf, 'modifiable', false)

  -- Clear previous highlights
  vim.api.nvim_buf_clear_namespace(state.buf, -1, 0, -1)

  -- Highlight current line
  vim.api.nvim_buf_add_highlight(
    state.buf,
    -1,
    'PmenuSel',
    state.current_index - 1,
    0,
    -1
  )
end

-- Move selection up
local function move_up()
  if state.current_index > 1 then
    state.current_index = state.current_index - 1
    render()
  end
end

-- Move selection down
local function move_down()
  if state.current_index < #state.items then
    state.current_index = state.current_index + 1
    render()
  end
end

-- Accept selection
local function accept()
  local selected = state.items[state.current_index]
  local callback = state.callback

  M.close()

  if callback and selected then
    callback(selected.value)
  end
end

-- Close selector
function M.close()
  if state.win and vim.api.nvim_win_is_valid(state.win) then
    vim.api.nvim_win_close(state.win, true)
  end

  state.buf = nil
  state.win = nil
  state.current_index = 1
  state.items = {}
  state.callback = nil
end

-- Setup keymaps
local function setup_keymaps()
  local opts = {noremap = true, silent = true, buffer = state.buf}

  -- Navigation
  vim.keymap.set('n', 'j', move_down, opts)
  vim.keymap.set('n', 'k', move_up, opts)
  vim.keymap.set('n', '<Down>', move_down, opts)
  vim.keymap.set('n', '<Up>', move_up, opts)

  -- Accept
  vim.keymap.set('n', '<CR>', accept, opts)
  vim.keymap.set('n', '<Space>', accept, opts)

  -- Cancel
  vim.keymap.set('n', 'q', M.close, opts)
  vim.keymap.set('n', '<Esc>', M.close, opts)
end

-- Open selector
-- @param items table: list of {label = "Display", value = "value"}
-- @param callback function: called with selected value
function M.open(items, callback)
  state.items = items
  state.callback = callback
  state.current_index = 1

  -- Create buffer
  state.buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_option(state.buf, 'buftype', 'nofile')
  vim.api.nvim_buf_set_option(state.buf, 'bufhidden', 'wipe')
  vim.api.nvim_buf_set_option(state.buf, 'swapfile', false)

  -- Calculate height based on number of items (add some padding)
  local height = math.min(#items + 2, 20)  -- Max 20 lines

  -- Create bottom split
  vim.cmd('botright ' .. height .. 'split')
  state.win = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_buf(state.win, state.buf)

  -- Window options
  vim.api.nvim_win_set_option(state.win, 'number', false)
  vim.api.nvim_win_set_option(state.win, 'relativenumber', false)
  vim.api.nvim_win_set_option(state.win, 'cursorline', false)
  vim.api.nvim_win_set_option(state.win, 'wrap', false)

  setup_keymaps()
  render()
end

return M
