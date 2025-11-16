-- Style presets for theme generation

local colors = require('mltb.colors')
local color_theory = require('mltb.color_theory')

local M = {}

-- Preset definitions
M.presets = {
  "truly random",
  "soft",
  "neon",
  "vibrant",
  "monochrome",
  "nature",
  "pastel",
}

-- Generate truly random theme (no rules)
-- @param is_dark boolean: true for dark theme, false for light
-- @return table: color palette
function M.generate_truly_random(is_dark)
  local palette = {}

  -- Background and foreground
  if is_dark then
    palette.bg = colors.get_random_color({"slate", "gray", "zinc", "neutral", "stone"}, {800, 900, 950})
    palette.fg = colors.get_random_color({"slate", "gray", "zinc", "neutral", "stone"}, {50, 100, 200})
  else
    palette.bg = colors.get_random_color({"slate", "gray", "zinc", "neutral", "stone"}, {50, 100})
    palette.fg = colors.get_random_color({"slate", "gray", "zinc", "neutral", "stone"}, {700, 800, 900})
  end

  -- Random accent colors
  palette.red = colors.get_random_color({"red", "rose", "pink"})
  palette.orange = colors.get_random_color({"orange", "amber"})
  palette.yellow = colors.get_random_color({"yellow", "amber"})
  palette.green = colors.get_random_color({"green", "lime", "emerald"})
  palette.cyan = colors.get_random_color({"cyan", "teal", "sky"})
  palette.blue = colors.get_random_color({"blue", "indigo", "sky"})
  palette.purple = colors.get_random_color({"purple", "violet", "fuchsia"})

  return palette
end

-- Generate soft/analogous theme (harmonious, gentle)
-- @param is_dark boolean: true for dark theme, false for light
-- @return table: color palette
function M.generate_soft(is_dark)
  local palette = {}

  -- Pick base hue
  local base_color = colors.get_random_color(nil, {500})
  local h, s, l = color_theory.hex_to_hsl(base_color)

  -- Reduce saturation for softness
  s = math.max(30, s * 0.6)

  -- Background and foreground
  if is_dark then
    palette.bg = color_theory.hsl_to_hex(h, s * 0.3, 10)
    palette.fg = color_theory.hsl_to_hex(h, s * 0.2, 90)
  else
    palette.bg = color_theory.hsl_to_hex(h, s * 0.2, 98)
    palette.fg = color_theory.hsl_to_hex(h, s * 0.3, 20)
  end

  -- Analogous colors (±30°)
  local analogous_hues = {
    (h - 30 + 360) % 360,
    h,
    (h + 30) % 360,
    (h + 60) % 360,
    (h - 60 + 360) % 360,
  }

  -- Assign colors
  palette.red = color_theory.hsl_to_hex(analogous_hues[1], s, is_dark and 70 or 50)
  palette.orange = color_theory.hsl_to_hex(analogous_hues[2], s, is_dark and 65 or 55)
  palette.yellow = color_theory.hsl_to_hex(analogous_hues[3], s, is_dark and 70 or 60)
  palette.green = color_theory.hsl_to_hex(analogous_hues[4], s, is_dark and 65 or 50)
  palette.cyan = color_theory.hsl_to_hex(analogous_hues[5], s, is_dark and 70 or 55)
  palette.blue = color_theory.hsl_to_hex(h, s, is_dark and 65 or 50)
  palette.purple = color_theory.hsl_to_hex((h + 15) % 360, s, is_dark and 70 or 55)

  return palette
end

-- Generate neon theme (high saturation, complementary)
-- @param is_dark boolean: true for dark theme, false for light
-- @return table: color palette
function M.generate_neon(is_dark)
  local palette = {}

  -- Background and foreground
  if is_dark then
    palette.bg = "#0a0a0a"
    palette.fg = "#ffffff"
  else
    palette.bg = "#ffffff"
    palette.fg = "#000000"
  end

  -- Pick base hue for neon colors
  local base_hue = math.random(0, 360)

  -- High saturation neon colors
  local sat = 100
  local light = is_dark and 60 or 50

  palette.red = color_theory.hsl_to_hex((base_hue + 0) % 360, sat, light)
  palette.orange = color_theory.hsl_to_hex((base_hue + 30) % 360, sat, light)
  palette.yellow = color_theory.hsl_to_hex((base_hue + 60) % 360, sat, light)
  palette.green = color_theory.hsl_to_hex((base_hue + 120) % 360, sat, light)
  palette.cyan = color_theory.hsl_to_hex((base_hue + 180) % 360, sat, light)
  palette.blue = color_theory.hsl_to_hex((base_hue + 240) % 360, sat, light)
  palette.purple = color_theory.hsl_to_hex((base_hue + 300) % 360, sat, light)

  return palette
end

-- Generate vibrant theme (triadic, high contrast)
-- @param is_dark boolean: true for dark theme, false for light
-- @return table: color palette
function M.generate_vibrant(is_dark)
  local palette = {}

  -- Pick base color
  local base_color = colors.get_random_color(nil, {500, 600})
  local h, s, l = color_theory.hex_to_hsl(base_color)

  -- Boost saturation
  s = math.min(100, s * 1.2)

  -- Background and foreground (neutral)
  if is_dark then
    palette.bg = "#1a1a1a"
    palette.fg = "#f5f5f5"
  else
    palette.bg = "#fafafa"
    palette.fg = "#1a1a1a"
  end

  -- Triadic scheme (120° apart)
  local h1 = h
  local h2 = (h + 120) % 360
  local h3 = (h + 240) % 360

  local light_val = is_dark and 60 or 45

  palette.red = color_theory.hsl_to_hex(h1, s, light_val)
  palette.orange = color_theory.hsl_to_hex((h1 + 30) % 360, s, light_val)
  palette.yellow = color_theory.hsl_to_hex(h2, s, light_val + 10)
  palette.green = color_theory.hsl_to_hex((h2 + 30) % 360, s, light_val)
  palette.cyan = color_theory.hsl_to_hex(h3, s, light_val)
  palette.blue = color_theory.hsl_to_hex((h3 + 30) % 360, s, light_val)
  palette.purple = color_theory.hsl_to_hex((h1 - 30 + 360) % 360, s, light_val)

  return palette
end

-- Generate monochrome theme (single hue, varying lightness)
-- @param is_dark boolean: true for dark theme, false for light
-- @return table: color palette
function M.generate_monochrome(is_dark)
  local palette = {}

  -- Pick base hue
  local base_color = colors.get_random_color(nil, {500})
  local h, s, l = color_theory.hex_to_hsl(base_color)

  -- Moderate saturation
  s = math.max(20, math.min(60, s))

  -- Background and foreground
  if is_dark then
    palette.bg = color_theory.hsl_to_hex(h, s * 0.3, 8)
    palette.fg = color_theory.hsl_to_hex(h, s * 0.2, 95)
  else
    palette.bg = color_theory.hsl_to_hex(h, s * 0.2, 98)
    palette.fg = color_theory.hsl_to_hex(h, s * 0.4, 15)
  end

  -- Varying lightness for different semantic colors
  if is_dark then
    palette.red = color_theory.hsl_to_hex(h, s, 70)
    palette.orange = color_theory.hsl_to_hex(h, s, 65)
    palette.yellow = color_theory.hsl_to_hex(h, s, 75)
    palette.green = color_theory.hsl_to_hex(h, s, 60)
    palette.cyan = color_theory.hsl_to_hex(h, s, 55)
    palette.blue = color_theory.hsl_to_hex(h, s, 65)
    palette.purple = color_theory.hsl_to_hex(h, s, 70)
  else
    palette.red = color_theory.hsl_to_hex(h, s, 40)
    palette.orange = color_theory.hsl_to_hex(h, s, 45)
    palette.yellow = color_theory.hsl_to_hex(h, s, 50)
    palette.green = color_theory.hsl_to_hex(h, s, 35)
    palette.cyan = color_theory.hsl_to_hex(h, s, 40)
    palette.blue = color_theory.hsl_to_hex(h, s, 45)
    palette.purple = color_theory.hsl_to_hex(h, s, 40)
  end

  return palette
end

-- Generate nature theme (greens, browns, earth tones)
-- @param is_dark boolean: true for dark theme, false for light
-- @return table: color palette
function M.generate_nature(is_dark)
  local palette = {}

  -- Background and foreground (brown/beige tones)
  if is_dark then
    palette.bg = colors.get_random_from_family("stone", {900, 950})
    palette.fg = colors.get_random_from_family("stone", {50, 100})
  else
    palette.bg = colors.get_random_from_family("stone", {50, 100})
    palette.fg = colors.get_random_from_family("stone", {800, 900})
  end

  -- Nature-inspired colors
  local shades = is_dark and {400, 500, 600} or {600, 700, 800}

  palette.red = colors.get_random_from_family("rose", shades)
  palette.orange = colors.get_random_from_family("amber", shades)
  palette.yellow = colors.get_random_from_family("amber", {is_dark and 300 or 600})
  palette.green = colors.get_random_from_family("emerald", shades)
  palette.cyan = colors.get_random_from_family("teal", shades)
  palette.blue = colors.get_random_from_family("sky", shades)
  palette.purple = colors.get_random_from_family("violet", shades)

  return palette
end

-- Generate pastel theme (desaturated, light/muted)
-- @param is_dark boolean: true for dark theme, false for light
-- @return table: color palette
function M.generate_pastel(is_dark)
  local palette = {}

  -- Pick base hue
  local base_hue = math.random(0, 360)

  -- Low saturation for pastel effect
  local sat = is_dark and 40 or 60

  -- Background and foreground
  if is_dark then
    palette.bg = color_theory.hsl_to_hex(base_hue, 15, 12)
    palette.fg = color_theory.hsl_to_hex(base_hue, 10, 92)
  else
    palette.bg = color_theory.hsl_to_hex(base_hue, 20, 97)
    palette.fg = color_theory.hsl_to_hex(base_hue, 15, 25)
  end

  -- Pastel colors with varying hues
  local light_val = is_dark and 70 or 65

  palette.red = color_theory.hsl_to_hex((base_hue + 0) % 360, sat, light_val)
  palette.orange = color_theory.hsl_to_hex((base_hue + 30) % 360, sat, light_val)
  palette.yellow = color_theory.hsl_to_hex((base_hue + 60) % 360, sat, light_val + 5)
  palette.green = color_theory.hsl_to_hex((base_hue + 120) % 360, sat, light_val)
  palette.cyan = color_theory.hsl_to_hex((base_hue + 180) % 360, sat, light_val)
  palette.blue = color_theory.hsl_to_hex((base_hue + 240) % 360, sat, light_val)
  palette.purple = color_theory.hsl_to_hex((base_hue + 300) % 360, sat, light_val)

  return palette
end

-- Main generator function - dispatches to specific preset
-- @param preset string: preset name
-- @param is_dark boolean: true for dark theme, false for light
-- @return table: color palette
function M.generate(preset, is_dark)
  if preset == "truly random" then
    return M.generate_truly_random(is_dark)
  elseif preset == "soft" then
    return M.generate_soft(is_dark)
  elseif preset == "neon" then
    return M.generate_neon(is_dark)
  elseif preset == "vibrant" then
    return M.generate_vibrant(is_dark)
  elseif preset == "monochrome" then
    return M.generate_monochrome(is_dark)
  elseif preset == "nature" then
    return M.generate_nature(is_dark)
  elseif preset == "pastel" then
    return M.generate_pastel(is_dark)
  else
    -- Default to truly random
    return M.generate_truly_random(is_dark)
  end
end

return M
