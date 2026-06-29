-- Useful debugging tools
_G.dd = function(...)
  Snacks.debug.inspect(...)
end
_G.bt = function()
  Snacks.debug.backtrace()
end

-- Contains folke/snacks related plugin configurations
return {
  { import = "plugins.snacks" },
  {
    "folke/snacks.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      bigfile = { enabled = false },
      dashboard = { enabled = false },
      image = { enabled = false },
      lazygit = { enabled = false },
      notifier = { enabled = false },
      quickfile = { enabled = false },
      scroll = { enabled = false },
      statuscolumn = { enabled = false },
      terminal = { enabled = false },
      toggle = { enabled = false },
      words = { enabled = false },
    },
  },
}
