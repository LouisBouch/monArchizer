local function lsp_from_ft_specs(ft_specs)
  local lsp_list = {}
  for _, specs in pairs(ft_specs) do
    for _, lsp in ipairs(specs.lang_servs or {}) do
      table.insert(lsp_list, lsp)
    end
  end
  return lsp_list or {}
end
-- The following languages should have language specific plugins.
-- https://github.com/neovim/nvim-lspconfig/wiki/Language-specific-plugins
-- Also, to check extra lsp capabilities of the buffer, run
-- :lua vim.print(vim.lsp.buf_get_clients()[1].server_capabilities.executeCommandProvider)
return {
  "neovim/nvim-lspconfig",
  version = "^2",
  config = function()
    -- Define keybindings for LSP
    vim.api.nvim_create_augroup("LSP", { clear = true })
    vim.api.nvim_create_autocmd({ "LspAttach" }, {
      callback = function()
        local k_opts = { desc = "Goto Definition" }
        local keymap = vim.keymap

        keymap.set("n", "gd", Snacks.picker.lsp_definitions, k_opts)

        k_opts.desc = "Goto Declaration"
        keymap.set("n", "gD", Snacks.picker.lsp_declarations, k_opts)

        k_opts.desc = "References"
        keymap.set("n", "gR", Snacks.picker.lsp_references, k_opts)

        k_opts.desc = "Goto Implementation"
        keymap.set("n", "gI", Snacks.picker.lsp_implementations, k_opts)

        k_opts.desc = "Goto T[y]pe Definition"
        vim.keymap.set("n", "gy", Snacks.picker.lsp_type_definitions, k_opts)

        k_opts.desc = "See available code actions"
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, k_opts)

        k_opts.desc = "Smart rename"
        keymap.set("n", "<leader>rn", vim.lsp.buf.rename, k_opts)

        k_opts.desc = "See function definition in popup window"
        keymap.set("n", "<leader>gs", vim.lsp.buf.hover, k_opts)

        k_opts.desc = "Diagnostics reset"
        keymap.set("n", "<leader>rd", vim.diagnostic.reset, k_opts)

        k_opts.desc = "Show buffer diagnostics"
        keymap.set("n", "<leader>sd", Snacks.picker.diagnostics, k_opts)

        k_opts.desc = "Show line diagnostics"
        keymap.set("n", "<leader>dd", vim.diagnostic.open_float, k_opts)
      end,
    })
    local lsp_set = meta_h.remove_dups(lsp_from_ft_specs(require("ft_specs")))
    vim.lsp.enable(lsp_set)
  end,
}
