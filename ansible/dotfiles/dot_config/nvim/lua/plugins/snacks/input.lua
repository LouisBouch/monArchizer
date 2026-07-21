return {
  "folke/snacks.nvim",
  opts = {
    input = {
      enabled = true,
      win = {
        keys = {
          i_alt_j = {
            "<A-j>",
            { "cmp_accept", "confirm" },
            mode = { "i", "n" },
            expr = true,
          },
        },
      },
    },
  },
}
