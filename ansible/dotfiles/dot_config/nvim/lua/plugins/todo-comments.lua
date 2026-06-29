return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "folke/snacks.nvim" },
  opts = {},
  keys = {
    {
      "<leader>xt",
      function()
        ---@diagnostic disable-next-line: undefined-field
        Snacks.picker.todo_comments() -- Don't know why it doesn't see it.
      end,
      desc = "List all todos (Todo Comments)",
    },
  },
}

