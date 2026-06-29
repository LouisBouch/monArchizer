local function linters_by_ft_from_ft_specs(ft_specs)
  local linters_by_ft = {}
  for ft, specs in pairs(ft_specs) do
    linters_by_ft[ft] = {}
    for _, linter in ipairs(specs.linters or {}) do
      table.insert(linters_by_ft[ft], linter)
    end
  end
  return linters_by_ft or {}
end
return {
  "mfussenegger/nvim-lint",
  config = function()
    local lint = require("lint")
    local linters_by_ft = linters_by_ft_from_ft_specs(require("ft_specs"))
    lint.linters_by_ft = linters_by_ft

    -- When to trigger the linter
    vim.api.nvim_create_augroup("lint", { clear = true })
    vim.api.nvim_create_autocmd({
      "BufEnter",
      "BufWritePost",
      "InsertLeave",
    }, {
      group = "lint",
      callback = function()
        lint.try_lint()
      end,
    })

    -- Manual linting
    vim.keymap.set("n", "<leader>li", function()
      lint.try_lint()
    end, { desc = "Triggers linting for current file" })

    -- Check active linters.
    vim.api.nvim_create_user_command("Linter", function()
      local ft = vim.bo.filetype
      local linters = lint.linters_by_ft[ft]
      if linters then
        print(
          "Active linters for " .. ft .. ": " .. table.concat(linters, ", ")
        )
      else
        print("No linters configured for " .. ft)
      end
    end, {})
  end,
}
