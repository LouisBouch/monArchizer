return {
  "stevearc/aerial.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    on_attach = function(bufnr)
      vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
      vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
    end,
    keymaps = {
      ["p"] = "actions.scroll",
      ["<C-j>"] = false,
      ["<C-k>"] = false,
      ["<C-p>"] = "actions.up_and_scroll",
      ["<C-n>"] = "actions.down_and_scroll",
      ["<A-j>"] = "actions.jump",
    },
  },
  keys = {
    { "<leader>A", "<cmd>AerialToggle!<CR>", desc = "Open aerial window" },
  },
}
