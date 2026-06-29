-- -- Helper
local function formatters_by_ft_from_ft_specs(ft_specs)
  local formatters_by_ft = {}
  for ft, specs in pairs(ft_specs) do
    formatters_by_ft[ft] = {}
    for _, formatter in ipairs(specs.formatters or {}) do
      table.insert(formatters_by_ft[ft], formatter)
    end
  end
  return formatters_by_ft or {}
end

-- -- Filetype configs

-- Lua
local stylua = {
  append_args = function(_, _)
    local fconf =
      vim.fs.find({ ".stylua.toml", "stylua.toml" }, { upward = true })[1]
    if fconf ~= nil then
      return {
        "--config-path",
        fconf,
      }
    else
      return {
        "--config-path",
        vim.fn.stdpath("config") .. "/stylua.toml",
      }
    end
  end,
}
return {
  "stevearc/conform.nvim",
  version = "^9",
  config = function()
    local conform = require("conform")
    local formatters_by_ft = formatters_by_ft_from_ft_specs(require("ft_specs"))

    -- Don't auto format
    vim.g.autoformat = false

    -- Initialize the configs set above
    conform.formatters.stylua = stylua

    conform.setup({
      formatters_by_ft = formatters_by_ft,
      format_on_save = function(_)
        -- Only format on save on specific configurations
        if
          vim.b.autoformat or (vim.b.autoformat == nil and vim.g.autoformat)
        then
          return {
            timeout_ms = 500,
            lsp_format = "fallback",
          }
        end
      end,
    })
  end,
  keys = {
    {
      "<leader>fo",
      function()
        require("conform").format({
          lsp_fallback = true,
          async = false,
          timeout = 500,
          quiet = false,
        })
      end,
      mode = { "n", "v" },
    },
  },
}
