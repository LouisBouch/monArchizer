-- -- Templates
-- Loads default template for latex files
vim.api.nvim_create_augroup("tex", { clear = true })
vim.api.nvim_create_autocmd({ "BufNewFile" }, {
  group = "tex",
  pattern = "*.tex",
  command = "0r" .. vim.fn.stdpath("config") .. "/lua/templates/tex.md",
})

-- -- Views
vim.api.nvim_create_augroup("view", { clear = true })

-- Creates view upon saving buffer
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  group = "view",
  pattern = "*",
  command = "silent! mkview",
})

-- Loads view upon opening buffer
vim.api.nvim_create_autocmd({ "BufReadPost" }, {
  group = "view",
  pattern = "*",
  command = "silent! loadview",
})

