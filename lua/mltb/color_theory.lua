-- Color theory utilities and color space conversions

local M = {}

-- Hex to RGB conversion
-- @param hex string: hex color like "#ff0000"
-- @return number, number, number: r, g, b values (0-255)
function M.hex_to_rgb(hex)
  hex = hex:gsub("#", "")
  return tonumber(hex:sub(1, 2), 16),
         tonumber(hex:sub(3, 4), 16),
         tonumber(hex:sub(5, 6), 16)
end

-- RGB to Hex conversion
-- @param r number: red value (0-255)
-- @param g number: green value (0-255)
-- @param b number: blue value (0-255)
-- @return string: hex color like "#ff0000"
function M.rgb_to_hex(r, g, b)
  return string.format("#%02x%02x%02x",
    math.floor(r + 0.5),
    math.floor(g + 0.5),
    math.floor(b + 0.5))
end

-- RGB to HSL conversion
-- @param r number: red value (0-255)
-- @param g number: green value (0-255)
-- @param b number: blue value (0-255)
-- @return number, number, number: h (0-360), s (0-100), l (0-100)
function M.rgb_to_hsl(r, g, b)
  r = r / 255
  g = g / 255
  b = b / 255

  local max = math.max(r, g, b)
  local min = math.min(r, g, b)
  local h, s, l = 0, 0, (max + min) / 2

  if max ~= min then
    local d = max - min
    s = l > 0.5 and d / (2 - max - min) or d / (max + min)

    if max == r then
      h = (g - b) / d + (g < b and 6 or 0)
    elseif max == g then
      h = (b - r) / d + 2
    else
      h = (r - g) / d + 4
    end
    h = h / 6
  end

  return h * 360, s * 100, l * 100
end

-- HSL to RGB conversion
-- @param h number: hue (0-360)
-- @param s number: saturation (0-100)
-- @param l number: lightness (0-100)
-- @return number, number, number: r, g, b values (0-255)
function M.hsl_to_rgb(h, s, l)
  h = h / 360
  s = s / 100
  l = l / 100

  local r, g, b

  if s == 0 then
    r = l
    g = l
    b = l
  else
    local function hue2rgb(p, q, t)
      if t < 0 then t = t + 1 end
      if t > 1 then t = t - 1 end
      if t < 1/6 then return p + (q - p) * 6 * t end
      if t < 1/2 then return q end
      if t < 2/3 then return p + (q - p) * (2/3 - t) * 6 end
      return p
    end

    local q = l < 0.5 and l * (1 + s) or l + s - l * s
    local p = 2 * l - q
    r = hue2rgb(p, q, h + 1/3)
    g = hue2rgb(p, q, h)
    b = hue2rgb(p, q, h - 1/3)
  end

  return math.floor(r * 255 + 0.5),
         math.floor(g * 255 + 0.5),
         math.floor(b * 255 + 0.5)
end

-- Hex to HSL conversion
-- @param hex string: hex color like "#ff0000"
-- @return number, number, number: h (0-360), s (0-100), l (0-100)
function M.hex_to_hsl(hex)
  local r, g, b = M.hex_to_rgb(hex)
  return M.rgb_to_hsl(r, g, b)
end

-- HSL to Hex conversion
-- @param h number: hue (0-360)
-- @param s number: saturation (0-100)
-- @param l number: lightness (0-100)
-- @return string: hex color like "#ff0000"
function M.hsl_to_hex(h, s, l)
  local r, g, b = M.hsl_to_rgb(h, s, l)
  return M.rgb_to_hex(r, g, b)
end

-- Get complementary color (180° opposite on color wheel)
-- @param hex string: base hex color
-- @return string: complementary hex color
function M.get_complementary(hex)
  local h, s, l = M.hex_to_hsl(hex)
  local comp_h = (h + 180) % 360
  return M.hsl_to_hex(comp_h, s, l)
end

-- Get triadic color scheme (120° apart)
-- @param hex string: base hex color
-- @return table: {hex1, hex2, hex3}
function M.get_triadic(hex)
  local h, s, l = M.hex_to_hsl(hex)

  return {
    hex,
    M.hsl_to_hex((h + 120) % 360, s, l),
    M.hsl_to_hex((h + 240) % 360, s, l)
  }
end

-- Get analogous color scheme (±30° adjacent colors)
-- @param hex string: base hex color
-- @return table: {hex1, hex2, hex3}
function M.get_analogous(hex)
  local h, s, l = M.hex_to_hsl(hex)

  return {
    M.hsl_to_hex((h - 30 + 360) % 360, s, l),
    hex,
    M.hsl_to_hex((h + 30) % 360, s, l)
  }
end

-- Get monochromatic color scheme (same hue, varying lightness)
-- @param hex string: base hex color
-- @param count number: number of variations (default 5)
-- @return table: {hex1, hex2, ..., hexN}
function M.get_monochromatic(hex, count)
  count = count or 5
  local h, s, l = M.hex_to_hsl(hex)

  local colors = {}
  local step = 80 / (count - 1)  -- Range from l-40 to l+40

  for i = 1, count do
    local new_l = math.max(0, math.min(100, l - 40 + (i - 1) * step))
    table.insert(colors, M.hsl_to_hex(h, s, new_l))
  end

  return colors
end

-- Adjust lightness of a color
-- @param hex string: base hex color
-- @param amount number: amount to adjust (-100 to 100)
-- @return string: adjusted hex color
function M.adjust_lightness(hex, amount)
  local h, s, l = M.hex_to_hsl(hex)
  local new_l = math.max(0, math.min(100, l + amount))
  return M.hsl_to_hex(h, s, new_l)
end

-- Adjust saturation of a color
-- @param hex string: base hex color
-- @param amount number: amount to adjust (-100 to 100)
-- @return string: adjusted hex color
function M.adjust_saturation(hex, amount)
  local h, s, l = M.hex_to_hsl(hex)
  local new_s = math.max(0, math.min(100, s + amount))
  return M.hsl_to_hex(h, new_s, l)
end

-- Calculate relative luminance (for contrast ratio)
-- @param hex string: hex color
-- @return number: relative luminance (0-1)
function M.get_luminance(hex)
  local r, g, b = M.hex_to_rgb(hex)

  -- Convert to 0-1 range
  r = r / 255
  g = g / 255
  b = b / 255

  -- Apply gamma correction
  local function adjust(c)
    if c <= 0.03928 then
      return c / 12.92
    else
      return ((c + 0.055) / 1.055) ^ 2.4
    end
  end

  r = adjust(r)
  g = adjust(g)
  b = adjust(b)

  -- Calculate luminance
  return 0.2126 * r + 0.7152 * g + 0.0722 * b
end

-- Calculate contrast ratio between two colors
-- @param hex1 string: first hex color
-- @param hex2 string: second hex color
-- @return number: contrast ratio (1-21)
function M.get_contrast_ratio(hex1, hex2)
  local lum1 = M.get_luminance(hex1)
  local lum2 = M.get_luminance(hex2)

  local lighter = math.max(lum1, lum2)
  local darker = math.min(lum1, lum2)

  return (lighter + 0.05) / (darker + 0.05)
end

-- Check if color combination meets WCAG AA standard (4.5:1 for normal text)
-- @param fg string: foreground hex color
-- @param bg string: background hex color
-- @return boolean: true if meets WCAG AA
function M.meets_wcag_aa(fg, bg)
  return M.get_contrast_ratio(fg, bg) >= 4.5
end

-- Check if color combination meets WCAG AAA standard (7:1 for normal text)
-- @param fg string: foreground hex color
-- @param bg string: background hex color
-- @return boolean: true if meets WCAG AAA
function M.meets_wcag_aaa(fg, bg)
  return M.get_contrast_ratio(fg, bg) >= 7.0
end

return M
