# MLTB - My Lovely Theme Builder

A Neovim plugin for generating beautiful, randomized themes using Tailwind CSS colors and color theory.

## Features

- **Direct commands** - Jump straight to generation (`:MLTBDarkSoft`, `:MLTBLightNeon`, etc.)
- **Auto-generated names** - Unique, memorable names like `midnight-crystal`, `forest-ember`
- **Minimal UI** - Clean, distraction-free theme browsing
- **7 style presets**: truly random, soft, neon, vibrant, monochrome, nature, pastel
- **Smart color theory** algorithms (complementary, triadic, analogous, monochromatic)
- **Session history** - navigate back and forward through generated themes
- **WCAG-compliant** contrast ratios for accessibility (4.5:1 minimum)

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

### Quick Start with Direct Commands

Jump straight into theme generation with direct commands:

```vim
:MLTBDark           " Dark theme, truly random
:MLTBDarkSoft       " Dark soft/harmonious theme
:MLTBDarkNeon       " Dark high-saturation theme
:MLTBDarkVibrant    " Dark triadic colors
:MLTBDarkMonochrome " Dark single-hue theme
:MLTBDarkNature     " Dark earth tones
:MLTBDarkPastel     " Dark muted colors

:MLTBLight          " Light theme, truly random
:MLTBLightSoft      " Light soft/harmonious theme
:MLTBLightNeon      " Light high-saturation theme
:MLTBLightVibrant   " Light triadic colors
:MLTBLightMonochrome" Light single-hue theme
:MLTBLightNature    " Light earth tones
:MLTBLightPastel    " Light muted colors
```

### Classic Menu Mode

Or use the classic menu for step-by-step selection:

```vim
:MLTBStart
```

This will:
1. Prompt you to choose **dark** or **light** theme
2. Prompt you to choose a **style preset**
3. Generate and apply the first theme

### Interactive Navigation

Once a theme is generated, a minimal UI appears with:

```
  midnight-crystal [1/5]

  [N] Next  [P] Prev  [S] Save  [Q] Quit
```

- **`N`** - Next (generate new theme or move forward in history)
- **`P`** - Prev (go back to previous theme)
- **`S`** - Save (save theme with auto-generated name)
- **`Q`** - Quit (close without saving)

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

## Auto-Generated Names

Each theme gets a unique, memorable name like:
- `midnight-crystal`
- `forest-ember`
- `azure-silk`
- `storm-shadow`
- `lavender-mist`
- `crimson-stone`
- `ocean-dream`

Names are generated from ~200 carefully curated words in each category, giving you thousands of unique combinations.

## Example Workflow

**Quick workflow:**
1. Run `:MLTBDarkSoft`
2. See theme name: `twilight-amber [1/1]`
3. Press `N` to try more variations
4. Press `P` to go back to one you liked
5. Press `S` to save it
6. Use `:colorscheme twilight-amber` anytime

**Or with menu:**
1. Run `:MLTBStart`
2. Select "dark"
3. Select "soft"
4. Navigate with `N`/`P`
5. Save with `S`

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
