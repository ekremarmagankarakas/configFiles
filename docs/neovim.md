# Neovim Configuration

A single Neovim config shared across macOS and Linux, built on [Lazy.nvim](https://github.com/folke/lazy.nvim).

## Plugin Manager

[Lazy.nvim](https://github.com/folke/lazy.nvim) -- plugins are lazy-loaded for fast startup. Open Neovim and run `:Lazy` to see plugin status.

## Plugin Overview

| Plugin | Purpose |
|--------|---------|
| [lazy.nvim](https://github.com/folke/lazy.nvim) | Plugin manager |
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | LSP client configurations |
| [mason.nvim](https://github.com/mason-org/mason.nvim) | Install LSP/DAP/formatters/linters |
| [mason-tool-installer.nvim](https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim) | Auto-install Mason tools |
| [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) | Autocompletion UI |
| [cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp) | LSP completion source |
| [cmp-buffer](https://github.com/hrsh7th/cmp-buffer) | Buffer completion source |
| [cmp-path](https://github.com/hrsh7th/cmp-path) | Path completion source |
| [cmp-cmdline](https://github.com/hrsh7th/cmp-cmdline) | Cmdline completion source |
| [cmp_luasnip](https://github.com/saadparwaiz1/cmp_luasnip) | LuaSnip completion source |
| [LuaSnip](https://github.com/L3MON4D3/LuaSnip) | Snippet engine |
| [friendly-snippets](https://github.com/rafamadriz/friendly-snippets) | Snippet collection |
| [conform.nvim](https://github.com/stevearc/conform.nvim) | Formatting runner |
| [nvim-lint](https://github.com/mfussenegger/nvim-lint) | Linting runner (CLI linters -> diagnostics) |
| [plenary.nvim](https://github.com/nvim-lua/plenary.nvim) | Lua utility library (dependency) |
| [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons) | Filetype icons (dependency) |
| [nui.nvim](https://github.com/MunifTanjim/nui.nvim) | UI components (dependency) |
| [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim) | File explorer |
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | Fuzzy finder |
| [telescope-fzf-native.nvim](https://github.com/nvim-telescope/telescope-fzf-native.nvim) | Faster telescope sorting |
| [telescope-ui-select.nvim](https://github.com/nvim-telescope/telescope-ui-select.nvim) | Use Telescope for `vim.ui.select` |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Syntax + parsing |
| [nvim-treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects) | Textobjects powered by Treesitter |
| [nvim-ts-autotag](https://github.com/windwp/nvim-ts-autotag) | Auto close/rename HTML/TSX tags |
| [flash.nvim](https://github.com/folke/flash.nvim) | Jump/motion enhancements |
| [trouble.nvim](https://github.com/folke/trouble.nvim) | Diagnostics/quickfix UI |
| [todo-comments.nvim](https://github.com/folke/todo-comments.nvim) | TODO/FIXME highlighting + search |
| [which-key.nvim](https://github.com/folke/which-key.nvim) | Keymap discovery popup |
| [harpoon](https://github.com/ThePrimeagen/harpoon) | Quick file switching |
| [undotree](https://github.com/mbbill/undotree) | Undo history UI |
| [nvim-surround](https://github.com/kylechui/nvim-surround) | Surround editing |
| [nvim-autopairs](https://github.com/windwp/nvim-autopairs) | Auto insert matching pairs |
| [middleclass](https://github.com/anuvyklack/middleclass) | Dependency for windows.nvim |
| [windows.nvim](https://github.com/anuvyklack/windows.nvim) | Window maximize |
| [markview.nvim](https://github.com/OXY2DEV/markview.nvim) | Markdown rendering in buffer |
| [vimtex](https://github.com/lervag/vimtex) | LaTeX editing/compile workflow |
| [vim-fugitive](https://github.com/tpope/vim-fugitive) | Git commands |
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Git hunks in the sign column |
| [lazygit.nvim](https://github.com/kdheepak/lazygit.nvim) | LazyGit integration |
| [diffview.nvim](https://github.com/sindrets/diffview.nvim) | Side-by-side diffs + merge UI |
| [copilot.lua](https://github.com/zbirenbaum/copilot.lua) | Copilot integration |
| [nvim-dap](https://github.com/mfussenegger/nvim-dap) | Debug Adapter Protocol client |
| [nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui) | DAP UI panes |
| [nvim-nio](https://github.com/nvim-neotest/nvim-nio) | Async utilities for DAP UI (dependency) |
| [nvim-dap-virtual-text](https://github.com/theHamsta/nvim-dap-virtual-text) | Inline DAP values |
| [nvim-dap-python](https://github.com/mfussenegger/nvim-dap-python) | Python debug helpers |
| [nvim-dap-go](https://github.com/leoluz/nvim-dap-go) | Go debug helpers |
| [nvim-dap-vscode-js](https://github.com/mxsdev/nvim-dap-vscode-js) | JS/TS debug adapter integration |
| [nvim-dap-lldb](https://github.com/julianolf/nvim-dap-lldb) | LLDB debug integration |
| [nvim-jdtls](https://github.com/mfussenegger/nvim-jdtls) | Java (Eclipse JDT) integration |
| [neoscroll.nvim](https://github.com/karb94/neoscroll.nvim) | Smooth scrolling |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | Statusline |
| [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) | Indent guides |
| [nvim-colorizer.lua](https://github.com/NvChad/nvim-colorizer.lua) | Inline color previews |
| [noice.nvim](https://github.com/folke/noice.nvim) | UI for cmdline/messages/notifications |
| [nvim-notify](https://github.com/rcarriga/nvim-notify) | Notification UI (dependency) |
| Themes (13 plugins) | catppuccin, nightfox, kanagawa, github-theme, onedarkpro, dracula, tokyonight, adwaita, rose-pine, gruvbox-material, everforest, cyberdream, vscode |

#### Language Tooling

| Language | LSP server | Formatter | Linter |
|----------|------------|-----------|--------|
| Lua | lua_ls | stylua | - |
| Python | pyright | ruff (format) | ruff (lint) |
| TypeScript/JavaScript | ts_ls | prettier | eslint_d |
| Go | gopls | goimports, gofumpt | - |
| Rust | rust_analyzer | rustfmt | - |
| C/C++ | clangd | clang-format | - |
| Zig | zls | zigfmt | - |
| Bash | bashls | shfmt | shellcheck |
| Markdown | marksman | prettier | - |
| Java | nvim-jdtls (JDTLS) | google-java-format | - |
| TeX/LaTeX | ltex (grammar) | latexindent | - |
| R | r_language_server | styler | - |

Configured debug adapters:

| Language | Adapter |
|----------|---------|
| Python | debugpy |
| Go | delve |
| JavaScript/TypeScript | vscode-js (pwa-node) |
| C/C++/Rust | codelldb |
| Java | java-debug-adapter + java-test |

Global toggles:
- `<leader>dtj` -- toggle `justMyCode` for Python debugging
- `<leader>dtv` -- toggle loading `.vscode/launch.json` configs

### Theme Picker

13 themes are installed and available through a persistent picker (`<leader>st`):

catppuccin, nightfox, kanagawa, github-theme, onedarkpro, dracula, tokyonight, adwaita, rose-pine, gruvbox-material, everforest, cyberdream, vscode

Your selection is saved to `~/.local/share/nvim/theme.txt` and persists across sessions.

## Core Options

From `nvim/lua/config/options.lua`:

| Option | Value | Note |
|--------|-------|------|
| Line numbers | relative | |
| Tab width | 4 spaces | expandtab enabled |
| Undo | persistent | survives restarts |
| Search | smart case | case-insensitive unless uppercase used |
| Leader | `Space` | |
| Local leader | `\` | |
| Scroll offset | 8 | cursor stays 8 lines from edge |
| Mouse | enabled | |
| Global statusline | yes | single statusline across splits |

## Directory Structure

```
nvim/
├── init.lua                 # Entry point, bootstraps Lazy.nvim
├── keymaps.md               # Full keybinding reference
├── lua/
│   ├── config/
│   │   ├── init.lua         # Loads options, keymaps, autocmds
│   │   ├── options.lua      # Core vim options
│   │   ├── keymaps.lua      # Non-plugin keybindings
│   │   ├── autocmds.lua     # Auto-commands (trim whitespace, md-to-pdf)
│   │   ├── diagnostics.lua  # Diagnostic display configuration
│   │   └── theme_picker.lua # Persistent theme selection
│   └── plugins/
│       ├── lsp.lua          # LSP + Mason + nvim-cmp
│       ├── format.lua       # Conform (formatters)
│       ├── lint.lua         # nvim-lint (linters)
│       ├── tools.lua        # Neo-tree, Flash, Trouble, Markview, etc.
│       ├── git.lua          # Fugitive, gitsigns, Copilot, LazyGit
│       ├── telescope.lua    # Telescope config and pickers
│       ├── treesitter.lua   # Treesitter + text objects
│       ├── ui.lua           # Themes, lualine, indent, noice
│       ├── debug.lua        # DAP config for all languages
│       ├── java.lua         # JDTLS with DAP integration
│       └── snippets.lua     # LuaSnip + friendly-snippets
```

## Java Setup

Java uses [nvim-jdtls](https://github.com/mfussenegger/nvim-jdtls) (not the built-in lspconfig) for full Eclipse JDT features:

- Auto-configures when opening `.java` files
- DAP integration with java-debug-adapter and java-test
- Keymaps: `<leader>jo` (organize imports), `<leader>jev/jec/jem` (extract variable/constant/method), `<leader>jtm/jtc` (test method/class)
