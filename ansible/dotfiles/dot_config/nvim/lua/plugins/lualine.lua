return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  opts = {
    options = {
      globalstatus = false,
      icons_enabled = true,
      theme = "auto",
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch", "diff", "diagnostics" },
      lualine_c = {
        {
          "filename",
          color = { fg = "", gui = "bold" },
        },
      },
      lualine_x = {
        -- TODO: Find substitute for noice
        -- Moves the messages that used to appear in the command line in
        -- lualine instead.
        -- Shows mode. Useful with macros (recording @a)
        {
          -- require("noice").api.status.mode.get,
          -- cond = require("noice").api.status.mode.has,
          -- color = { fg = "#ff9e64" },
        },
        -- Shows last command executed
        {
          -- require("noice").api.status.command.get,
          -- cond = require("noice").api.status.command.has,
          -- color = { fg = "#ff9e64" },
        },
      },
      lualine_y = {
        { "progress", separator = " ", padding = { left = 1, right = 0 } },
        { "location", padding = { left = 0, right = 1 } },
      },
      lualine_z = {
        function()
          return " " .. os.date("%R")
        end,
      },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { "filename" },
      lualine_x = { "location" },
      lualine_y = {},
      lualine_z = {},
    },
  },
}
