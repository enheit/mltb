-- MLTB - My Lovely Theme Builder
-- Main plugin entry point

local generator = require('mltb.generator')
local presets = require('mltb.presets')
local ui = require('mltb.ui')

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

-- Start the theme generation process with menus (backward compatibility)
function M.start()
  -- Step 1: Ask for theme type (dark/light)
  vim.ui.select(
    {'dark', 'light'},
    {
      prompt = 'Select theme type:',
    },
    function(theme_type)
      if not theme_type then
        vim.notify("Theme generation cancelled", vim.log.levels.INFO)
        return
      end

      -- Step 2: Ask for style preset
      vim.ui.select(
        presets.presets,
        {
          prompt = 'Select style preset:',
        },
        function(preset)
          if not preset then
            vim.notify("Theme generation cancelled", vim.log.levels.INFO)
            return
          end

          M.start_with(theme_type, preset)
        end
      )
    end
  )
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
