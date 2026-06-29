-- -- IMPORTANT
-- Even though we usually think about programming languages when we code, neovim
-- only sees filetypes. For this reason, if you want to setup linting/formatting
-- and more for a specific language, you should set it up for its corresponding
-- filetype(s).
-- To see which filetype a buffer uses, run `:set filetype?`, or run
-- `:lua print(vim.filetype.match { filename = ".rs" })` with the actual file
-- extension and not ".rs".
-- For a list of filetypes, see [https://github.com/neovim/neovim/blob/master/runtime/lua/vim/filetype.lua#L2451]
-- Similarly, for a list of parsers, see [https://github.com/tree-sitter/tree-sitter/wiki/List-of-parsers]
--
-- Also, this here is only for listing the tools used. To access the configs for
-- each filetype, go to the corresponding tool's directory (lsp, dap, formatting, ...)


---@class Filetype
---@field parser? string Tree-sitter parser
---@field formatters? string[] List of formatters
---@field linters? string[] List of linters
---@field lang_servs? string[] Language server(s) (Almost always just one)
---@field debug_adps? string[] Debug adapter(s) (Almost always just one)

---@type table<string, Filetype> List of language servers/debug adapters/... for each filetype
local M = {}

M = {
  lua = { -- Lua, .lua
    parser = "lua",
    formatters = { "stylua" },
    linters = { "selene" },
    lang_servs = { "lua_ls", },
    debug_adps = { "osv_lua" },
  },
  rust = { -- Rust, .rs
    parser = "rust",
    lang_servs = { "rust_analyzer", },
  },
  -- TODO: Check if entry is required for .h and .hpp files
  c = { -- C, .c .h
    parser = "c",
  },
  cpp = { -- C++, .cpp .hpp
    parser = "cpp",
    formatters = { "clang-format" },
    lang_servs = { "clangd" },
    debug_adps = { "codelldb" },
  },
  markdown = { -- Markdown, .md
    parser = "markdown",
    formatters = { "prettier" },
  },
  css = { -- CSS, .css
    parser = "css",
    formatters = { "prettier" },
  },
  slint = {
    parser = "slint",
    lang_servs = { "slint_lsp" },
  },
  html = { -- HTML, .html
    parser = "html",
    formatters = { "prettier" },
  },
  sql = { -- SQL, .sql
    parser = "sql",
  },
  json = { --- Json, .json
    parser = "json",
    formatters = { "prettier" },
    linters = { "jsonlint" },
  },
  python = { -- Python, .py
    parser = "python",
    formatters = { "ruff_format" },
    lang_servs = { "basedpyright" },
  },
  plaintex = { -- Latex, .tex
    parser = "latex",
    formatters = { "tex-fmt" },
  },
  sh = { -- Bash, .sh
    parser = "bash",
  },
  zsh = { -- Zsh, .zsh
    parser = "zsh",
  },
  toml = { -- TOML, .toml
    parser = "toml",
    lang_servs = { "tombi" },
  },
  vim = { -- Vimscript, .vim
    parser = "vim",
  },
  awk = { -- AWK, .awk
    parser = "awk",
  },
}


return M
