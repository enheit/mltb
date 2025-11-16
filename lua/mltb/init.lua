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

-- Start the theme generation process
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

          -- Generate initial theme
          local initial_theme = generator.create_theme(preset, theme_type)

          -- Create generator function for subsequent themes
          local generator_func = function()
            return generator.create_theme(preset, theme_type)
          end

          -- Open UI with initial theme
          ui.open(initial_theme, theme_type, preset, generator_func)
        end
      )
    end
  )
end

-- Create user commands
vim.api.nvim_create_user_command('MLTBStart', function()
  M.start()
end, {
  desc = 'Start MLTB theme generator',
})

return M
