-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "é"

-- -- Basic configs for neovim
local opt = vim.opt

-- Clipboard synchronysation
opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus"

