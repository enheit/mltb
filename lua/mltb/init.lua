-- MLTB - My Lovely Theme Builder
-- Main plugin entry point

local generator = require('mltb.generator')
local presets = require('mltb.presets')
local ui = require('mltb.ui')
local selector = require('mltb.selector')

local M = {}

-- Plugin state
M.config = {
  themes_dir = vim.fn.stdpath('config') .. '/themes',
}

-- Setup function
function M.setup(opts)
  opts = opts or {}
  M.config = vim.tbl_extend('force', M.config, opts)

  -- Update writer config
  local writer = require('mltb.writer')
  writer.themes_dir = M.config.themes_dir
end

-- Start theme generation with specific type and preset
-- @param theme_type string: "dark" or "light"
-- @param preset string: preset name
function M.start_with(theme_type, preset)
  -- Generate initial theme
  local initial_theme = generator.create_theme(preset, theme_type)

  -- Create generator function for subsequent themes
  local generator_func = function()
    return generator.create_theme(preset, theme_type)
  end

  -- Open UI with initial theme
  ui.open(initial_theme, theme_type, preset, generator_func)
end

-- Capitalize first letter of each word
local function capitalize(str)
  return str:gsub("(%a)([%w_']*)", function(first, rest)
    return first:upper() .. rest
  end)
end

-- Start the theme generation process with menus (backward compatibility)
function M.start()
  -- Build list of all theme options
  local items = {}
  local theme_types = {'dark', 'light'}

  for _, theme_type in ipairs(theme_types) do
    for _, preset in ipairs(presets.presets) do
      local label = capitalize(theme_type) .. " " .. capitalize(preset)
      table.insert(items, {
        label = label,
        value = {type = theme_type, preset = preset}
      })
    end
  end

  -- Show selector
  selector.open(items, function(selection)
    if selection then
      M.start_with(selection.type, selection.preset)
    end
  end)
end

-- Create user commands
vim.api.nvim_create_user_command('MLTBStart', function()
  M.start()
end, {
  desc = 'Start MLTB theme generator with menu prompts',
})

-- Direct commands for dark themes
vim.api.nvim_create_user_command('MLTBDark', function()
  M.start_with('dark', 'truly random')
end, {
  desc = 'Generate dark theme (truly random)',
})

vim.api.nvim_create_user_command('MLTBDarkSoft', function()
  M.start_with('dark', 'soft')
end, {
  desc = 'Generate dark soft theme',
})

vim.api.nvim_create_user_command('MLTBDarkNeon', function()
  M.start_with('dark', 'neon')
end, {
  desc = 'Generate dark neon theme',
})

vim.api.nvim_create_user_command('MLTBDarkVibrant', function()
  M.start_with('dark', 'vibrant')
end, {
  desc = 'Generate dark vibrant theme',
})

vim.api.nvim_create_user_command('MLTBDarkMonochrome', function()
  M.start_with('dark', 'monochrome')
end, {
  desc = 'Generate dark monochrome theme',
})

vim.api.nvim_create_user_command('MLTBDarkNature', function()
  M.start_with('dark', 'nature')
end, {
  desc = 'Generate dark nature theme',
})

vim.api.nvim_create_user_command('MLTBDarkPastel', function()
  M.start_with('dark', 'pastel')
end, {
  desc = 'Generate dark pastel theme',
})

-- Direct commands for light themes
vim.api.nvim_create_user_command('MLTBLight', function()
  M.start_with('light', 'truly random')
end, {
  desc = 'Generate light theme (truly random)',
})

vim.api.nvim_create_user_command('MLTBLightSoft', function()
  M.start_with('light', 'soft')
end, {
  desc = 'Generate light soft theme',
})

vim.api.nvim_create_user_command('MLTBLightNeon', function()
  M.start_with('light', 'neon')
end, {
  desc = 'Generate light neon theme',
})

vim.api.nvim_create_user_command('MLTBLightVibrant', function()
  M.start_with('light', 'vibrant')
end, {
  desc = 'Generate light vibrant theme',
})

vim.api.nvim_create_user_command('MLTBLightMonochrome', function()
  M.start_with('light', 'monochrome')
end, {
  desc = 'Generate light monochrome theme',
})

vim.api.nvim_create_user_command('MLTBLightNature', function()
  M.start_with('light', 'nature')
end, {
  desc = 'Generate light nature theme',
})

vim.api.nvim_create_user_command('MLTBLightPastel', function()
  M.start_with('light', 'pastel')
end, {
  desc = 'Generate light pastel theme',
})

return M
