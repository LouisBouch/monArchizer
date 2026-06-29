local function parsers_from_ft_specs(ft_specs)
  local parsers = {}
  for _, specs in pairs(ft_specs) do
    if specs.parser then
      table.insert(parsers, specs.parser)
    end
  end
  return parsers or {}
end
return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  build = ":TSUpdate",
  config = function()
    local treesitter = require("nvim-treesitter")
    local ensure_installed = {
      "regex",
      "gitignore",
      "query",
    }
    -- Merge ensure installed with list of configured filetypes/languages
    treesitter.install(
      vim.tbl_deep_extend(
        "force",
        ensure_installed,
        parsers_from_ft_specs(require("ft_specs"))
      )
    )
  end,
}
