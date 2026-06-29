return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
  ---@module 'oil'
  ---@type oil.SetupOpts
  -- Personal type, ignore warning.
  opts = {
    constrain_cursor = "name",
    columns = {
      "icon",
      "permissions",
      { "size", highlight = "OilHidden" },
      { "mtime", highlight = "OilHidden" },
      {
        "type",
        highlight = "OilDir",
        icons = { file = "|", directory = "|", link = "|" },
      },
    },
    keymaps = {
      ["<A-j>"] = "actions.select",
      ["<C-g>"] = "actions.parent",
      ["~"] = {
        callback = function()
          require("oil.actions").cd.callback()
          require("oil.actions").open_cwd.callback()
        end,
        opts = { scope = "tab" },
        mode = "n",
      },
    },
    view_options = {
      show_hidden = true,
    },
    float = {
      -- Padding around the floating window
      padding = 3,
      border = "rounded",
      -- optionally override the oil buffers window title with custom function: fun(winid: integer): string
      get_win_title = function(winid)
        local bufnr = vim.fn.winbufnr(winid)
        local cwd = vim.fn.getcwd(winid)
        local cur_path = require("oil").get_current_dir(bufnr)
        local rel_path = vim.fs.relpath(cwd, cur_path or "/")
        rel_path = (((rel_path ~= nil) and "./" .. rel_path) or cur_path):gsub(
          "%.$",
          ""
        )
        return rel_path
      end,
      -- preview_split: Split direction: "auto", "left", "right", "above", "below".
      preview_split = "auto",
    },
  },
  keys = {
    { "<leader>e", "<cmd>Oil --float<CR>", desc = "Open explorer" },
  },
  --
  -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
  lazy = false,
}
