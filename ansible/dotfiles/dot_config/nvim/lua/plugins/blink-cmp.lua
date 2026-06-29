-- More configs: https://cmp.saghen.dev/installation
return {
  "saghen/blink.cmp",
  dependencies = {
    { "rafamadriz/friendly-snippets" },
    { "L3MON4D3/LuaSnip", version = "^2" },
  },
  version = "^1",
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = {
      preset = "default",
      ["<A-j>"] = { "select_and_accept" },
      ["<C-e>"] = { "cancel" },
    },
    snippets = {
      preset = "luasnip",
    },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
      per_filetype = {
        lua = { inherit_defaults = true, "lazydev" },
      },
      providers = {
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          -- make lazydev completions top priority (see `:h blink`)
          score_offset = 100,
        },
      },
    },
  },
  fuzzy = { implementation = "prefer_rust_with_warning" },
}
