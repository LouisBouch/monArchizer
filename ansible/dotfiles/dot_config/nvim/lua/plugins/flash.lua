return {
 "folke/flash.nvim",
  event = "VeryLazy",
  ---@type Flash.Config
  opts = {
    modes = {
      char = {
        enabled = false
      }
    }
  },
  keys = {
    { "R", mode = {"n", "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
  },
}
