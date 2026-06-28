return {
  "ellisonleao/gruvbox.nvim",
  config = function()
    -- Ensure parameters have different color from member variables.
    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "gruvbox",
      callback = function()
        vim.cmd("highlight! link @parameter GruvboxAqua")
      end,
    })
  end,
}
