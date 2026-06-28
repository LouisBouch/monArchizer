return {
  "EdenEast/nightfox.nvim",
  config = function()
    -- Makes trailing whitespaces visible.
    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "*fox",
      callback = function()
        -- Current whitespace highlight.
        local whitespace_hl = vim.api.nvim_get_hl(0, { name = "Whitespace" }).fg

        -- Value to add to whitespace highlight.
        local extra_hl = tonumber("0x101010")

        -- Set new value for trailing whitespaces.
        vim.api.nvim_set_hl(0, "Whitespace", { fg = whitespace_hl + extra_hl })
      end,
    })
  end,
}
