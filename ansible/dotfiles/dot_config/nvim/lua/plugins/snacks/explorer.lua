local custom_layout = {
  box = "vertical",
  width = 0.85,
  height = 0.85,
  {
    box = "vertical",
    border = "rounded",
    title = "{source} {live} {flags}",
    title_pos = "center",
    { win = "input", height = 1, border = "bottom" },
    { win = "list", border = "none" },
  },
  {
    win = "preview",
    border = "rounded",
    title = "{preview}",
  },
}
return {
  "folke/snacks.nvim",
  opts = {
    explorer = {
      replace_netrw = true,
      enabled = true,
    },
    picker = {
      sources = {
        explorer = {
          win = {
            -- input window
            input = {
              keys = {
                ["<C-g>"] = { { "explorer_up" }, mode = { "n", "i" } },
                ["<C-.>"] = { { "explorer_focus" }, mode = { "n", "i" } },
                ["<C-,>"] = { { "tcd" }, mode = { "n", "i" } },
              },
            },
            list = {
              keys = {
                ["<C-g>"] = { { "explorer_up" }, mode = { "n", "i" } },
              },
            },
          },
          focus = "input",
          -- Floating browser
          layout = {
            preview = true,
            layout = custom_layout,
          },
          auto_close = true,
        },
      },
    },
  },
  keys = {
    {
      "<leader>fe",
      function()
        require("snacks").explorer({})
      end,
      desc = "File Explorer",
    },
  },
}
