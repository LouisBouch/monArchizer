---Apply a function to every element in the table and return the new one.
---@generic V, R
---@param table V[]
---@param f fun(v: V): R
---@return R[]
local function map(table, f)
  local mapped = {}
  for i, v in ipairs(table) do
    mapped[i] = f(v)
  end
  return mapped
end
-- List of color schemes
local colorSchemes = {
  {
    { "folke/tokyonight.nvim" },
    variants = { "tokyonight-moon", "tokyonight-night", "tokyonight-storm" },
  },
  { { "ellisonleao/gruvbox.nvim" }, variants = { "gruvbox" } },
  {
    { "catppuccin/nvim", name = "catppuccin" },
    variants = {
      "catppuccin-frappe",
      "catppuccin-macchiato",
      "catppuccin-mocha",
    },
  },
  {
    { "rebelot/kanagawa.nvim" },
    variants = { "kanagawa-dragon", "kanagawa-wave" },
  },
  {
    { "EdenEast/nightfox.nvim" },
    variants = { "nightfox", "duskfox", "nordfox", "terafox", "carbonfox" },
  },
  {
    { "rose-pine/neovim", name = "rose-pine" },
    variants = { "rose-pine-main", "rose-pine-moon" },
  },
  { { "navarasu/onedark.nvim" }, variants = { "onedark" } },
  { { "sainnhe/gruvbox-material" }, variants = { "gruvbox-material" } },
  { { "sharpchen/Eva-Theme.nvim" }, variants = { "Eva-Dark-Bold" } },
}

-- List of urls
local urls = map(colorSchemes, function(v)
  local t = v[1]
  t.lazy = true
  t.category = meta_h.categories.colorscheme
  return t
end)

-- List of variants and plugin name
local plugins = map(colorSchemes, function(v)
  local plugName = v[1].name or v[1][1]:match(".*/(.*)$")
  return { v.variants, plugin = plugName }
end)

-- Load random colorscheme after plugins have loaded
vim.api.nvim_create_autocmd("User", {
  pattern = "LazyDone",
  callback = function()
    math.randomseed(os.time())
    -- Fetch random colorscheme plugin
    local plugNb = math.random(#plugins)
    local plug = plugins[plugNb].plugin
    local variants = plugins[plugNb][1]

    -- Fetch random variant from plugin
    local varNb = math.random(#variants)
    local theme = variants[varNb]

    -- Load plugin, as it is set as lazy.
    -- Note: Does no seem necessary when colorscheme is set within schedule,
    -- but I'll keep it just in case.
    require("lazy").load({ plugins = { plug } })

    -- Schedule is required, because autocmd signals are suppressed in this loop.
    vim.schedule(function()
      vim.cmd.colorscheme(theme)
      -- Always invert color at cursor.
      -- vim.api.nvim_set_hl(0, "Cursor", { reverse = true })
    end)
  end,
})

-- Ensure they are loaded by lazy.nvim
return urls
