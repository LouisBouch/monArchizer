return {
  "folke/trouble.nvim",
  opts = {}, -- for default options, refer to the configuration section for custom setup.
  cmd = "Trouble",
  keys = {
    {
      "<leader>xx",
      "<cmd>Trouble diagnostics toggle<cr>",
      desc = "Diagnostics (Trouble)",
    },
    {
      "<leader>xX",
      "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
      desc = "Buffer Diagnostics (Trouble)",
    },
    {
      "]d",
      function()
        vim.diagnostic.jump({ count = 1, float = true })
      end,
      desc = "Go to next diagnostic",
    },
    {
      "[d",
      function()
        vim.diagnostic.jump({ count = -1, float = true })
      end,
      desc = "Go to previous diagnostic",
    },
    -- Test the following commands before accepting the mappings.
    -- {
    --   "<leader>cs",
    --   "<cmd>Trouble symbols toggle focus=false<cr>",
    --   desc = "Symbols (Trouble)",
    -- },
    -- {
    --   "<leader>cl",
    --   "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
    --   desc = "LSP Definitions / references / ... (Trouble)",
    -- },
    -- {
    --   "<leader>xL",
    --   "<cmd>Trouble loclist toggle<cr>",
    --   desc = "Location List (Trouble)",
    -- },
    -- {
    --   "<leader>xQ",
    --   "<cmd>Trouble qflist toggle<cr>",
    --   desc = "Quickfix List (Trouble)",
    -- },
  },
}
