-- UI module - bottom split menu for theme navigation

local writer = require('mltb.writer')

local M = {}

-- UI state
local state = {
  buf = nil,
  win = nil,
  history = {},  -- List of generated themes
  current_index = 1,
  theme_type = nil,
  preset = nil,
  generator_func = nil,  -- Function to generate new themes
}

-- Render the menu
local function render_menu()
  if not state.buf or not vim.api.nvim_buf_is_valid(state.buf) then
    return
  end

  local lines = {}
  local current_theme = state.history[state.current_index]

  -- Title
  table.insert(lines, "╭─────────────────────────────────────────────────────────╮")
  table.insert(lines, "│         MLTB - My Lovely Theme Builder                 │")
  table.insert(lines, "╰─────────────────────────────────────────────────────────╯")
  table.insert(lines, "")

  -- Theme info
  if current_theme then
    table.insert(lines, "Theme Info:")
    table.insert(lines, "  Type: " .. state.theme_type)
    table.insert(lines, "  Preset: " .. state.preset)
    table.insert(lines, "  History: " .. state.current_index .. "/" .. #state.history)
    table.insert(lines, "")

    -- Color palette preview
    table.insert(lines, "Palette:")
    local p = current_theme.palette
    table.insert(lines, "  BG: " .. p.bg .. "  FG: " .. p.fg)
    table.insert(lines, "  Red: " .. p.red .. "  Orange: " .. p.orange)
    table.insert(lines, "  Yellow: " .. p.yellow .. "  Green: " .. p.green)
    table.insert(lines, "  Cyan: " .. p.cyan .. "  Blue: " .. p.blue)
    table.insert(lines, "  Purple: " .. p.purple)
  else
    table.insert(lines, "No theme generated yet")
  end

  table.insert(lines, "")
  table.insert(lines, "────────────────────────────────────────────────────────────")
  table.insert(lines, "")

  -- Keybindings
  table.insert(lines, "Keybindings:")
  table.insert(lines, "  [N] - Next")
  table.insert(lines, "  [P] - Prev")
  table.insert(lines, "  [A] - Accept")
  table.insert(lines, "  [Q] - Quit")
  table.insert(lines, "")

  -- Set buffer content
  vim.api.nvim_buf_set_option(state.buf, 'modifiable', true)
  vim.api.nvim_buf_set_lines(state.buf, 0, -1, false, lines)
  vim.api.nvim_buf_set_option(state.buf, 'modifiable', false)
end

-- Setup keymaps for the menu
local function setup_keymaps()
  local opts = {noremap = true, silent = true, buffer = state.buf}

  -- Accept theme (A or a)
  vim.keymap.set('n', 'A', function() M.accept_theme() end, opts)
  vim.keymap.set('n', 'a', function() M.accept_theme() end, opts)

  -- Quit (Q or q)
  vim.keymap.set('n', 'Q', function() M.close() end, opts)
  vim.keymap.set('n', 'q', function() M.close() end, opts)

  -- Next theme (N or n)
  vim.keymap.set('n', 'N', function() M.next_theme() end, opts)
  vim.keymap.set('n', 'n', function() M.next_theme() end, opts)

  -- Previous theme (P or p)
  vim.keymap.set('n', 'P', function() M.back_theme() end, opts)
  vim.keymap.set('n', 'p', function() M.back_theme() end, opts)
end

-- Accept current theme (save it)
function M.accept_theme()
  local current_theme = state.history[state.current_index]
  if not current_theme then
    vim.notify("No theme to accept", vim.log.levels.WARN)
    return
  end

  -- Generate theme name
  local theme_name = writer.generate_theme_name(state.theme_type, state.preset)

  -- Save theme
  local filepath = writer.save_theme(current_theme, theme_name)

  vim.notify(string.format("Theme saved: %s", theme_name), vim.log.levels.INFO)

  -- Close UI
  M.close()
end

-- Navigate to next theme
function M.next_theme()
  -- If not at the end of history, just move forward
  if state.current_index < #state.history then
    state.current_index = state.current_index + 1
    local theme = state.history[state.current_index]
    writer.apply_theme(theme)
    render_menu()
    vim.notify("Showing theme " .. state.current_index .. "/" .. #state.history, vim.log.levels.INFO)
    return
  end

  -- At the end of history, generate a new theme
  if not state.generator_func then
    vim.notify("No generator function set", vim.log.levels.ERROR)
    return
  end

  local new_theme = state.generator_func()
  table.insert(state.history, new_theme)
  state.current_index = #state.history

  writer.apply_theme(new_theme)
  render_menu()

  vim.notify("Generated new theme (" .. #state.history .. " in history)", vim.log.levels.INFO)
end

-- Go back to previous theme in history
function M.back_theme()
  if state.current_index <= 1 then
    vim.notify("Already at first theme", vim.log.levels.WARN)
    return
  end

  -- Move back in history
  state.current_index = state.current_index - 1

  -- Apply previous theme
  local prev_theme = state.history[state.current_index]
  writer.apply_theme(prev_theme)
  render_menu()

  vim.notify("Showing theme " .. state.current_index .. "/" .. #state.history, vim.log.levels.INFO)
end

-- Close the UI
function M.close()
  if state.win and vim.api.nvim_win_is_valid(state.win) then
    vim.api.nvim_win_close(state.win, true)
  end

  -- Reset state
  state.buf = nil
  state.win = nil
  state.history = {}
  state.current_index = 1
  state.theme_type = nil
  state.preset = nil
  state.generator_func = nil

  vim.notify("MLTB closed", vim.log.levels.INFO)
end

-- Open the UI with initial theme
-- @param initial_theme table: first theme to show
-- @param theme_type string: "dark" or "light"
-- @param preset string: preset name
-- @param generator_func function: function to generate new themes
function M.open(initial_theme, theme_type, preset, generator_func)
  -- Store state
  state.theme_type = theme_type
  state.preset = preset
  state.generator_func = generator_func
  state.history = {initial_theme}
  state.current_index = 1

  -- Apply initial theme
  writer.apply_theme(initial_theme)

  -- Create buffer
  state.buf = vim.api.nvim_create_buf(false, true)

  -- Set buffer options
  vim.api.nvim_buf_set_option(state.buf, 'buftype', 'nofile')
  vim.api.nvim_buf_set_option(state.buf, 'bufhidden', 'wipe')
  vim.api.nvim_buf_set_option(state.buf, 'swapfile', false)
  vim.api.nvim_buf_set_option(state.buf, 'filetype', 'mltb')

  -- Create bottom split (15 lines high)
  vim.cmd('botright 15split')
  state.win = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_buf(state.win, state.buf)

  -- Set window options
  vim.api.nvim_win_set_option(state.win, 'number', false)
  vim.api.nvim_win_set_option(state.win, 'relativenumber', false)
  vim.api.nvim_win_set_option(state.win, 'cursorline', false)
  vim.api.nvim_win_set_option(state.win, 'wrap', false)

  -- Setup keymaps and render
  setup_keymaps()
  render_menu()
end

return M
