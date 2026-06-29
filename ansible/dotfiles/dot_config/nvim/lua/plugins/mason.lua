-- Define name for mason package if the name of the tool does not match it.
-- Use a false value to indicate you don't want mason to install it.
local package_name_mapping = {
  -- LSP
  lua_ls = "lua-language-server",
  rust_analyzer = false,
  slint_lsp = "slint-lsp",
  -- Formatter
  ruff_format = "ruff",
  -- DAP
  osv_lua = false,
}
local function mason_packages_from_ft_specs(ft_specs)
  local packages = {}
  for _, specs in pairs(ft_specs) do
    for pack_type, pack_list in pairs(specs or {}) do
      if pack_type == "parser" then goto continue end
      for _, pack in ipairs(pack_list or {}) do
        local mapping = package_name_mapping[pack]
        if mapping == false then goto continue end
        table.insert(packages, mapping or pack)
      end
      ::continue::
    end
  end
  return packages or {}
end
return {
  {
    "mason-org/mason.nvim",
    version = "^2",
    opts = {
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    },
  },
  -- To automatically install stuff from mason.
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = {
      "williamboman/mason.nvim",
    },
    config = function()
      local ensure_installed = meta_h.remove_dups(mason_packages_from_ft_specs(require("ft_specs")))
      local opts = {
        ensure_installed = ensure_installed,
      }
      require("mason-tool-installer").setup(opts)
    end,
  },
}

