return { 
  "nvim-mini/mini.jump2d",
  opts = {
    allowed_windows = { not_current = false },
    view = {
      dim = true,
      n_steps_ahead = 1,
    },
    labels = 'abcdefghijklmnopqrstuvwxyz;ACDEFHIJKLMNOPQRSUVWXYZ:',
  },
  config = function(_, opts)
    require('mini.jump2d').setup(opts)
  end,
  keys = {
    { "F", mode = {"n", "o", "x" }, function()
      local spotter = MiniJump2d.builtin_opts.line_start
      spotter.allowed_lines = { cursor_before = true, cursor_after = true }
      MiniJump2d.start(spotter)
    end,
    desc = "Jump to start of any line in buffer" },

    { "f", mode = {"n", "o", "x" }, function()
      local spotter = MiniJump2d.builtin_opts.single_character
      spotter.allowed_lines = { cursor_before = true, cursor_after = true }
      MiniJump2d.start(spotter)
    end,
    desc = "Jump to any character visible in buffer" },

    { "t", mode = {"n", "o", "x" }, function()
      local spotter = MiniJump2d.builtin_opts.single_character
      spotter.allowed_lines = { cursor_before = true, cursor_after = true }
      spotter.hooks.after_jump = function()
        vim.cmd("normal! h")
      end
      MiniJump2d.start(spotter)
    end,
    desc = "Jump to any character visible in buffer and act like 't'" },

    { "T", mode = {"n", "o", "x" }, function()
      local spotter = MiniJump2d.builtin_opts.single_character
      spotter.allowed_lines = { cursor_before = true, cursor_after = true }
      spotter.hooks.after_jump = function()
        vim.cmd("normal! l")
      end
      MiniJump2d.start(spotter)
    end,
    desc = "Jump to any character visible in buffer and act like 'T'" },
  },
}
