-- -- REGUlAR KEY MAPPINGS

---A keymap object containing all fields necessary for applying a keymap.
---@class Keymap
---@field mode string|string[] Mode "short-name" (see nvim_set_keymap or map-modes).
---@field lhs string           Left-hand side {lhs} of the mapping.
---@field rhs string|function  Right-hand side {rhs} of the mapping, can be a Lua function.
---@field ft? string|string[]  Filetypes for which the command is set.
---@field opts? vim.keymap.set.Opts Optional parameters:
---    "<noremap>" disables |recursive_mapping|, like |:noremap|
---    "<desc>" human-readable description.
---    "<callback>" Lua function called in place of {rhs}.
---    "<replace_keycodes>" (boolean) When "expr" is true, replace
---    "<buffer>"
---    "<nowait>"
---    "<silent>"
---    "<script>"
---    "<expr>"
---    "<unique>"
---    "<remap>"

---Create mappings
---@param keymaps Keymap[]
local function applyKeymaps(keymaps)
  -- Autocommand group for autocommands that create file specific keymaps.
  vim.api.nvim_create_augroup("ft_keymaps", { clear = true })
  for _, keymap in ipairs(keymaps) do
    if keymap.ft ~= nil then
      -- For when the keymap has been defined for specific filetypes.
      vim.api.nvim_create_autocmd("FileType", {
        pattern = keymap.ft,
        group = "ft_keymaps",
        callback = function(event)
          local opts = keymap.opts or {}
          opts.buffer = event.buf
          vim.keymap.set(keymap.mode, keymap.lhs, keymap.rhs, opts)
        end,
      })
    else
      -- For when the keymap has not been defined for specific filetypes.
      vim.keymap.set(keymap.mode, keymap.lhs, keymap.rhs, keymap.opts or {})
    end
  end
end

---List of key mappings
---@type Keymap[]
local mappings = {
  { mode = { "n", "x" }, lhs = "<Space>", rhs = "<Nop>" },

  -- Extra deleting commands
  { mode = { "i", "c", "t" }, lhs = "<C-l>", rhs = "<Del>" },
  { mode = { "i", "c", "t" }, lhs = "<C-h>", rhs = "<BS>" },
  {
    mode = { "i" },
    lhs = "<C-d>",
    rhs = "<Space><Esc>ce",
    opts = { desc = "Simulates ctrl-delete" },
  },

  -- Movement
  -- { mode = { "n", "x" }, lhs = "<C-d>", rhs = "<C-d>zz" },
  -- { mode = { "n", "x" }, lhs = "<C-u>", rhs = "<C-u>zz" },
  { mode = { "n", "x" }, lhs = "<C-l>", rhs = "4zl" },
  { mode = { "n", "x" }, lhs = "<C-h>", rhs = "4zh" },
  { mode = { "n", "x" }, lhs = "<C-S-L>", rhs = "zL" },
  { mode = { "n", "x" }, lhs = "<C-S-H>", rhs = "zH" },
  { mode = { "n", "x" }, lhs = "j", rhs = "gj" },
  { mode = { "n", "x" }, lhs = "k", rhs = "gk" },
  { mode = { "n", "x" }, lhs = "<A-w>", rhs = "<C-w>_<C-w>|" }, -- Full size window
  { mode = { "n", "x" }, lhs = "<A-f>", rhs = "f" },
  { mode = { "n", "x" }, lhs = "<A-F>", rhs = "F" },
  { mode = { "n", "x" }, lhs = "<A-t>", rhs = "t" },
  { mode = { "n", "x" }, lhs = "<A-T>", rhs = "T" },

  -- Exit terminal mode
  {
    mode = { "t" },
    lhs = "<A-c>",
    rhs = [[<C-\><C-n>]],
    opts = { desc = "Normal mode within terminal" },
  },

  -- Extra enter mapping
  { mode = { "n", "v", "i", "o", "c", "t" }, lhs = "<A-j>", rhs = "<Enter>" },

  -- Revamping deletion to act like actual deletion and not cutting.
  -- Add special cutting binding.
  { mode = { "n", "x" }, lhs = "x", rhs = '"_x' },
  { mode = { "n", "x" }, lhs = "X", rhs = '"_X' },
  { mode = { "n", "x" }, lhs = "c", rhs = '"_c' },
  { mode = { "n", "x" }, lhs = "C", rhs = '"_C' },
  { mode = { "n", "x" }, lhs = "d", rhs = '"_d' },
  { mode = { "n", "x" }, lhs = "D", rhs = '"_D' },
  { mode = { "n", "x" }, lhs = "s", rhs = '"_s' },
  { mode = { "n", "x" }, lhs = "S", rhs = '"_S' },

  {
    mode = { "x" },
    lhs = "p",
    rhs = "P",
    opts = { desc = "Don't yank text being replaced" },
  },
  {
    mode = { "x" },
    lhs = "P",
    rhs = "p",
    opts = { desc = "Yank text being replaced" },
  },

  { mode = { "n", "x" }, lhs = "m", rhs = "d" },
  { mode = { "n", "x" }, lhs = "M", rhs = "D" },
  {
    mode = { "n", "x" },
    lhs = "gm",
    rhs = "m",
    opts = { desc = "Set a mark" },
  },

  -- Add new lines while in normal mode.
  { mode = { "n" }, lhs = "<A-o>", rhs = "o<C-c>" },
  { mode = { "n" }, lhs = "<A-O>", rhs = "O<C-c>" },

  {
    mode = { "n" },
    lhs = "<C-g>",
    rhs = function()
      local cwd = vim.fn.getcwd(0)
      local slashed_cwd = cwd:gsub("/(.+)", "/%1/") -- Add / to end expect for root
      local file_path = vim.api.nvim_buf_get_name(0)
      local rel_path = vim.fs.relpath(cwd, file_path)
      local path_print = rel_path
          and {
            { "buf: ", "@character" },
            { slashed_cwd, "@character.special" },
            { rel_path },
          }
        or { { "buf: ", "@character" }, { file_path } }
      vim.api.nvim_echo({ { "cwd: ", "@character" }, { cwd } }, true, {})
      vim.api.nvim_echo(path_print, true, {})
    end,
    opts = { desc = "Show cwd and current buffer path" },
  },
}
applyKeymaps(mappings)
