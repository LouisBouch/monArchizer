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
