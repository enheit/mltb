-- Theme name generator with curated word lists

local M = {}

-- First words (~200 words)
M.first_words = {
  -- Times & celestial
  "midnight", "dawn", "dusk", "twilight", "noon", "sunset", "sunrise", "eclipse", "aurora", "starlight",
  "moonlight", "daybreak", "evening", "morning", "shadow", "zenith", "solstice", "equinox",

  -- Nature & landscapes
  "ocean", "mountain", "forest", "desert", "meadow", "valley", "canyon", "glacier", "volcano", "river",
  "lake", "island", "reef", "cave", "cliff", "shore", "coast", "beach", "dune", "marsh",
  "prairie", "tundra", "savanna", "jungle", "rainforest", "woodland", "highland", "lowland",

  -- Weather & elements
  "storm", "mist", "frost", "rain", "snow", "thunder", "lightning", "fog", "haze", "drizzle",
  "wind", "breeze", "gale", "tempest", "blizzard", "cyclone", "tornado", "hurricane",

  -- Flora
  "cherry", "rose", "violet", "lavender", "iris", "lotus", "jasmine", "orchid", "lily", "dahlia",
  "magnolia", "azalea", "camellia", "peony", "tulip", "daffodil", "poppy", "sunflower",
  "fern", "moss", "vine", "bamboo", "willow", "cedar", "pine", "oak", "maple", "birch",

  -- Minerals & gems
  "crystal", "diamond", "ruby", "sapphire", "emerald", "amethyst", "topaz", "quartz", "opal", "jade",
  "pearl", "coral", "amber", "garnet", "turquoise", "obsidian", "marble", "granite", "slate", "onyx",

  -- Animals & creatures
  "raven", "falcon", "eagle", "hawk", "owl", "dove", "swan", "crane", "heron", "phoenix",
  "dragon", "wolf", "fox", "bear", "deer", "tiger", "panther", "leopard", "lynx", "lion",
  "whale", "dolphin", "shark", "orca", "seal", "otter", "serpent", "cobra", "viper",

  -- Abstract & qualities
  "dream", "whisper", "echo", "silence", "harmony", "rhythm", "melody", "symphony", "cascade",
  "radiant", "velvet", "silk", "satin", "linen", "cotton", "wool", "leather", "suede",
  "cosmic", "ethereal", "mystic", "ancient", "modern", "vintage", "classic", "nova", "quantum",
  "digital", "analog", "electric", "magnetic", "atomic", "lunar", "solar", "stellar", "nebula",

  -- Metals & materials
  "gold", "silver", "bronze", "copper", "iron", "steel", "platinum", "titanium", "chrome", "brass",
  "pewter", "tin", "mercury", "lead", "zinc", "aluminum", "nickel",

  -- Colors (as first words)
  "crimson", "scarlet", "vermillion", "cardinal", "cherry", "ruby", "wine", "burgundy",
  "azure", "cobalt", "navy", "royal", "cerulean", "sapphire", "indigo", "ultramarine",
  "emerald", "jade", "olive", "lime", "mint", "sage", "forest", "hunter",
  "golden", "amber", "honey", "mustard", "ochre", "bronze", "copper", "rust",
  "violet", "purple", "mauve", "plum", "lavender", "lilac", "orchid", "magenta",
  "ivory", "pearl", "cream", "vanilla", "beige", "tan", "sand", "wheat",
  "charcoal", "graphite", "ash", "smoke", "slate", "storm", "steel", "pewter",
}

-- Second words (~200 words)
M.second_words = {
  -- Colors & shades
  "blue", "red", "green", "yellow", "orange", "purple", "pink", "brown", "gray", "black",
  "white", "crimson", "scarlet", "azure", "emerald", "amber", "violet", "indigo", "cyan", "magenta",
  "maroon", "navy", "teal", "olive", "lime", "coral", "salmon", "peach", "cream", "ivory",
  "beige", "tan", "khaki", "bronze", "copper", "gold", "silver", "platinum", "pewter", "charcoal",

  -- Materials & textures
  "stone", "rock", "pebble", "boulder", "gravel", "sand", "clay", "mud", "soil", "earth",
  "glass", "crystal", "diamond", "gem", "jewel", "metal", "iron", "steel", "brass", "copper",
  "wood", "timber", "oak", "pine", "cedar", "maple", "bamboo", "silk", "velvet", "satin",
  "cotton", "wool", "linen", "leather", "suede", "canvas", "denim", "tweed",

  -- Natural elements
  "flame", "fire", "blaze", "ember", "spark", "ash", "smoke", "steam", "vapor", "cloud",
  "mist", "fog", "haze", "rain", "dew", "frost", "ice", "snow", "sleet", "hail",
  "wave", "tide", "surf", "foam", "spray", "ripple", "current", "flow", "stream", "creek",
  "breeze", "wind", "gust", "gale", "storm", "thunder", "lightning", "bolt",

  -- Abstract & concepts
  "dream", "vision", "mirage", "illusion", "phantom", "shadow", "shade", "ghost", "spirit", "soul",
  "echo", "whisper", "murmur", "sigh", "breath", "pulse", "rhythm", "beat", "tempo",
  "light", "glow", "shine", "gleam", "glimmer", "shimmer", "sparkle", "glint", "flash", "flare",
  "dark", "dusk", "dawn", "twilight", "midnight", "noon", "zenith", "horizon",

  -- Spatial & dimensional
  "depths", "heights", "peaks", "valleys", "plains", "fields", "lands", "realms", "worlds", "spheres",
  "void", "abyss", "chasm", "rift", "gap", "space", "expanse", "vista", "range",

  -- Temporal
  "age", "era", "epoch", "time", "moment", "instant", "eternity", "infinity", "forever",
  "spring", "summer", "autumn", "winter", "season", "solstice", "equinox",

  -- Qualities
  "bloom", "blossom", "petal", "bud", "leaf", "branch", "root", "seed", "fruit", "berry",
  "crest", "crown", "peak", "summit", "apex", "point", "edge", "ridge", "spine",
  "heart", "core", "center", "nexus", "hub", "focus", "node", "axis",
  "wing", "feather", "scale", "fur", "hide", "skin", "shell", "horn", "claw", "fang",

  -- Phenomena
  "aurora", "eclipse", "nova", "comet", "meteor", "star", "constellation", "galaxy", "nebula",
  "cascade", "waterfall", "rapids", "falls", "fountain", "spring", "geyser",
  "rainbow", "prism", "spectrum", "hue", "tint", "shade", "tone", "cast",
}

-- Generate a random theme name
function M.generate_name()
  math.randomseed(os.time() + vim.loop.hrtime())

  local first = M.first_words[math.random(#M.first_words)]
  local second = M.second_words[math.random(#M.second_words)]

  return first .. "-" .. second
end

-- Generate a unique name (check against existing files)
function M.generate_unique_name(existing_names)
  existing_names = existing_names or {}

  -- Create a set for faster lookup
  local names_set = {}
  for _, name in ipairs(existing_names) do
    names_set[name] = true
  end

  -- Try up to 100 times to find a unique name
  for _ = 1, 100 do
    local name = M.generate_name()
    if not names_set[name] then
      return name
    end
  end

  -- Fallback: add timestamp
  return M.generate_name() .. "-" .. os.time()
end

return M
