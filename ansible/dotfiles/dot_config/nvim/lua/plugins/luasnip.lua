return {
  "L3MON4D3/LuaSnip",
  version = "^2",
  config = function()
    -- Possible fix to the annoying tab teleportation.
    -- vim.api.nvim_create_autocmd("ModeChanged", {
    --   pattern = "*",
    --   callback = function()
    --     if
    --       (
    --         (vim.v.event.old_mode == "s" and vim.v.event.new_mode == "n")
    --         or vim.v.event.old_mode == "i"
    --       )
    --       and require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
    --       and not require("luasnip").session.jump_active
    --     then
    --       require("luasnip").unlink_current()
    --     end
    --   end,
    -- })
    -- local luasnip = require("luasnip")
    -- Example snipppet
    -- local s = luasnip.snippet
    -- local i = luasnip.insert_node
    -- local t = luasnip.text_node
    -- local c = luasnip.choice_node
    -- luasnip.add_snippets("lua", {
    --   s("else", {
    --     t({ "else", "\t" }),
    --     i(1, "--code"),
    --     t({ "", "end" }),
    --   }),
    -- })
  end,
}
