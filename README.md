# MLTB - My Lovely Theme Builder

A Neovim plugin for generating beautiful, randomized themes using Tailwind CSS colors and color theory.

## Features

- **Interactive theme generation** with live preview
- **7 style presets**: truly random, soft, neon, vibrant, monochrome, nature, pastel
- **Smart color theory** algorithms (complementary, triadic, analogous, monochromatic)
- **WCAG-compliant** contrast ratios for accessibility
- **Session history** - navigate back through generated themes
- **Auto-naming** - themes saved with descriptive names like `mltb-dark-soft-001.lua`

## Installation

### Using [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
{
  'enheit/mltb',
  config = function()
    require('mltb').setup()
  end
}
```

### Using [packer.nvim](https://github.com/wbthomason/packer.nvim)

```lua
use {
  'enheit/mltb',
  config = function()
    require('mltb').setup()
  end
}
```

## Usage

### Generate Themes

Run the command:

```vim
:MLTBStart
```

This will:
1. Prompt you to choose **dark** or **light** theme
2. Prompt you to choose a **style preset**
3. Generate and apply the first theme
4. Open an interactive menu for navigation

### Interactive Menu

Once the menu opens, you can:

- **`1` or `a`** - Accept theme (save to disk)
- **`2` or `r`** - Reject (close without saving)
- **`3` or `n`** - Next (generate a new random theme)
- **`4` or `b`** - Back (go to previous theme in history)
- **`q`** - Quit

### Style Presets

- **truly random** - Completely random colors, no rules
- **soft** - Analogous color scheme, muted saturation, harmonious
- **neon** - High saturation, vibrant, complementary colors
- **vibrant** - Triadic scheme with bold, high-contrast colors
- **monochrome** - Single hue with varying lightness levels
- **nature** - Earth tones (greens, browns, teals, ambers)
- **pastel** - Desaturated, soft, gentle colors

## Configuration

```lua
require('mltb').setup({
  -- Directory where generated themes are saved
  themes_dir = vim.fn.stdpath('config') .. '/themes',
})
```

## Generated Theme Location

By default, themes are saved to:

```
~/.config/nvim/themes/
```

Each theme is a standalone `.lua` file that can be:
- Used with `:colorscheme <theme-name>`
- Manually edited
- Shared with others
- Selected with [MLTS](https://github.com/enheit/mlts) (My Lovely Theme Selector)

## Example Workflow

1. Run `:MLTBStart`
2. Select "dark"
3. Select "soft"
4. Theme is generated and applied
5. Press `n` to try more variations
6. Press `b` to go back to a previous one you liked
7. Press `a` to save it
8. Use `:colorscheme mltb-dark-soft-001` anytime

## Color Theory

MLTB uses proper color theory algorithms:

- **HSL color space** for transformations
- **Complementary** - 180° opposite on color wheel
- **Triadic** - 120° apart for vibrant palettes
- **Analogous** - ±30° for harmonious schemes
- **Monochromatic** - Single hue, varying lightness
- **WCAG AA** contrast compliance (4.5:1 minimum)

## License

MIT
