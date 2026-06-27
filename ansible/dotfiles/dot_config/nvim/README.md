# Neovim configs to replace <sup><sub><sub><sub>_almost_</sub></sub></sup> all editors

These configs aim to include any essential feature that could be expected from an editor alongside the benefits of using vim motions.  
This includes:

- **Language servers** (Uses the language server protocol "LSP" to give autocompletion/hints for your code.)
- **Formatting**
- **Linting** (Tool to analyze code and flag potential problems.)
- **Debuggers** (Uses the debugging adapter protocol "DAP" to allow debugging of running code.)
- **Tree-sitters** (Builds syntax trees to help with code navigation and indentation.)
- **File editor**
- **Fuzzy finder** (Allows to search for files quicker through approximate string matching.)
- **Colorschemes**
- **And much more!**

## Adding languages

To add full compatibility with a specific language, the following steps usually suffice:

- Add the **language parser** to the tree-sitter
- Add a **language server** using mason and set it up with **nvim-lspconfig**
- Add a **formatter** using mason and set it up with **conform.nvim**
- Add a **linter** using mason and set it up with **nvim-lint**
- Add a **debugger** server using mason and set it up with **nvim-dap**

To install the tools, one can follow the established grammar [here](lua/langs/tools.lua).  
To configure it, it suffices to create a file in the correct language config diretory.  
For example:

- lua's formatting configs are set [here](lua/langs/formatting/stylua.lua).
- lua's debugging configs are set [here](lua/langs/dap/debugee_configs/lua.lua) for the adapter
  and [here](lua/langs/dap/adapter_configs/osv_lua.lua) for the debugee.

These steps can be omitted at the cost of their functionality, but language servers and tree-sitters are _highly_ recommended.  
Unfortunately, not all languages are as easy to setup, and some require extra plugins to make work.

## External dependencies

The following external plugins and packages are required in order to achieve full compatibility with these configs.

- [ripgrep](https://github.com/BurntSushi/ripgrep)
- [git](https://git-scm.com/downloads/linux)
- [curl](https://curl.se/download.html) (Usually installed by default)
- [unzip](https://infozip.sourceforge.net/UnZip.html)
- [tar](https://www.gnu.org/software/tar/)
- [gzip](https://www.gnu.org/software/gzip/)
- [cargo](https://www.rust-lang.org/tools/install) (For rust)
- [npm](https://nodejs.org/en/download) (For npm dependent projects)
- [imagemagick](https://imagemagick.org/) (To see images within pickers)

## Plugins

The following is a list of plugins separated in different categories.

Note that [snacks.nvim](https://github.com/folke/snacks.nvim) is a repository of many functionalities and not a single plugin.  
This repository includes:

- [snacks-indent](https://github.com/folke/snacks.nvim/blob/main/docs/indent.md)
- [snacks-picker](https://github.com/folke/snacks.nvim/blob/main/docs/picker.md)
- [snacks-explorer](https://github.com/folke/snacks.nvim/blob/main/docs/explorer.md)
- [snacks-input](https://github.com/folke/snacks.nvim/blob/main/docs/input.md)

### Coding: Allow faster coding with features such as snippets, autocompletion, and more.

- [LuaSnip](https://github.com/L3MON4D3/LuaSnip)
- [blink.cmp](https://github.com/saghen/blink.cmp)
  - [LuaSnip](https://github.com/L3MON4D3/LuaSnip)
  - [friendly-snippets](https://github.com/rafamadriz/friendly-snippets)
- [friendly-snippets](https://github.com/rafamadriz/friendly-snippets)
- [mini.pairs](https://github.com/nvim-mini/mini.pairs)
- [ts-comments.nvim](https://github.com/folke/ts-comments.nvim)

### Editor: Provide functionality like a file explorer, search and replace, fuzzy finding, git integration.

- [aerial.nvim](https://github.com/stevearc/aerial.nvim)
  - [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
  - [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons)
- [harpoon](https://github.com/ThePrimeagen/harpoon)
  - [plenary.nvim](https://github.com/nvim-lua/plenary.nvim)
- [hop.nvim](https://github.com/smoka7/hop.nvim)
- [oil.nvim](https://github.com/stevearc/oil.nvim)
  - [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons)
- [todo-comments.nvim](https://github.com/folke/todo-comments.nvim)
  - [plenary.nvim](https://github.com/nvim-lua/plenary.nvim)
  - [snacks.nvim](https://github.com/folke/snacks.nvim)
- [toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim)
- [trouble.nvim](https://github.com/folke/trouble.nvim)
- [vimtex](https://github.com/lervag/vimtex)

### DAP: Configure the Debug Adapter Protocol (DAP) client.

- [nvim-dap](https://github.com/mfussenegger/nvim-dap)
- [nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui)
  - [nvim-dap](https://github.com/mfussenegger/nvim-dap)
  - [nvim-nio](https://github.com/nvim-neotest/nvim-nio)
- [nvim-dap-virtual-text](https://github.com/theHamsta/nvim-dap-virtual-text)
  - [nvim-dap](https://github.com/mfussenegger/nvim-dap)
  - [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
- [one-small-step-for-vimkind](https://github.com/jbyuki/one-small-step-for-vimkind)
  - [nvim-dap](https://github.com/mfussenegger/nvim-dap)

### Treesitter: Provide advanced syntax highlighting and plugins that use Treesitter parsers.

- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)

### Formatting: Set up formatters using *conform.nvim*.

- [conform.nvim](https://github.com/stevearc/conform.nvim)

### LSP: Configure the Language Server Protocol (LSP) client.

- [lazydev.nvim](https://github.com/folke/lazydev.nvim)
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)

### Linting: Manage linters with the *nvim-lint* plugin.

- [nvim-lint](https://github.com/mfussenegger/nvim-lint)

### UI: Enhance the user interface with features such as status line, buffer line, indentation guides, dashboard, and icons.

- [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)
  - [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons)
- [noice.nvim](https://github.com/folke/noice.nvim)
  - [nui.nvim](https://github.com/MunifTanjim/nui.nvim)
  - [nvim-notify](https://github.com/rcarriga/nvim-notify)

### Colorschemes: Provide color palettes to be chosen from when opening a neovim sessions.

- [Eva-Theme.nvim](https://github.com/sharpchen/Eva-Theme.nvim)
- [catppuccin](https://github.com/catppuccin/nvim)
- [gruvbox-material](https://github.com/sainnhe/gruvbox-material)
- [gruvbox.nvim](https://github.com/ellisonleao/gruvbox.nvim)
- [kanagawa.nvim](https://github.com/rebelot/kanagawa.nvim)
- [nightfox.nvim](https://github.com/EdenEast/nightfox.nvim)
- [onedark.nvim](https://github.com/navarasu/onedark.nvim)
- [rose-pine](https://github.com/rose-pine/neovim)
- [tokyonight.nvim](https://github.com/folke/tokyonight.nvim)

### Util: Contains utilities for session management, shared functionality, and other handy tools.

- [mason-tool-installer.nvim](https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim)
  - [mason.nvim](https://github.com/williamboman/mason.nvim)
- [mason.nvim](https://github.com/williamboman/mason.nvim)

### Others (mostly dependencies from other plugins)

- [lazy.nvim](https://github.com/folke/lazy.nvim)
- [nui.nvim](https://github.com/MunifTanjim/nui.nvim)
- [nvim-nio](https://github.com/nvim-neotest/nvim-nio)
- [nvim-notify](https://github.com/rcarriga/nvim-notify)
- [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons)
- [plenary.nvim](https://github.com/nvim-lua/plenary.nvim)
- [snacks.nvim](https://github.com/folke/snacks.nvim)
  - [trouble.nvim](https://github.com/folke/trouble.nvim)
