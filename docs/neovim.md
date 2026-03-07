# Neovim Configuration

A single Neovim config shared across macOS and Linux, built on [Lazy.nvim](https://github.com/folke/lazy.nvim).

## Plugin Manager

[Lazy.nvim](https://github.com/folke/lazy.nvim) lazy-loads plugins for fast startup. Use `:Lazy` to inspect status.

## Active Plugin Overview

| Plugin | Purpose |
|--------|---------|
| [lazy.nvim](https://github.com/folke/lazy.nvim) | Plugin manager |
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | LSP client configuration |
| [mason.nvim](https://github.com/mason-org/mason.nvim) | Install LSP/DAP/formatters/linters |
| [mason-tool-installer.nvim](https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim) | Auto-install Mason tools |
| [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) + cmp sources | Completion engine |
| [LuaSnip](https://github.com/L3MON4D3/LuaSnip) + [friendly-snippets](https://github.com/rafamadriz/friendly-snippets) | Snippets |
| [conform.nvim](https://github.com/stevearc/conform.nvim) | Formatting |
| [nvim-lint](https://github.com/mfussenegger/nvim-lint) | Linting |
| [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim) | File explorer |
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) + extensions | Fuzzy finder |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) + textobjects + autotag | Parsing, highlighting, text objects |
| [flash.nvim](https://github.com/folke/flash.nvim) | Motion enhancements |
| [todo-comments.nvim](https://github.com/folke/todo-comments.nvim) | TODO/FIXME navigation/search |
| [which-key.nvim](https://github.com/folke/which-key.nvim) | Keymap hints |
| [harpoon](https://github.com/ThePrimeagen/harpoon) | Quick file marks/navigation |
| [undotree](https://github.com/mbbill/undotree) | Undo history UI |
| [nvim-surround](https://github.com/kylechui/nvim-surround) | Surround editing |
| [nvim-autopairs](https://github.com/windwp/nvim-autopairs) | Auto-pairs |
| [markview.nvim](https://github.com/OXY2DEV/markview.nvim) | Markdown rendering |
| [mkdnflow.nvim](https://github.com/jakewvincent/mkdnflow.nvim) | Markdown link/todo workflow |
| [vimtex](https://github.com/lervag/vimtex) | TeX/LaTeX workflow |
| [vim-fugitive](https://github.com/tpope/vim-fugitive) | Git commands |
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Git hunks/signs |
| [lazygit.nvim](https://github.com/kdheepak/lazygit.nvim) | LazyGit integration |
| [diffview.nvim](https://github.com/sindrets/diffview.nvim) | Diff and merge UI |
| [copilot.lua](https://github.com/zbirenbaum/copilot.lua) | Copilot suggestions |
| [CopilotChat.nvim](https://github.com/CopilotC-Nvim/CopilotChat.nvim) | Copilot chat/actions |
| [nvim-dap](https://github.com/mfussenegger/nvim-dap) + UI helpers | Debugging |
| [nvim-dap-python](https://github.com/mfussenegger/nvim-dap-python) | Python debug helpers |
| [nvim-dap-go](https://github.com/leoluz/nvim-dap-go) | Go debug helpers |
| [nvim-dap-vscode-js](https://github.com/mxsdev/nvim-dap-vscode-js) | JS/TS debug adapter integration |
| [nvim-dap-lldb](https://github.com/julianolf/nvim-dap-lldb) | C/C++/Rust LLDB integration |
| [nvim-jdtls](https://github.com/mfussenegger/nvim-jdtls) | Java LSP + DAP/test integration |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | Statusline |
| [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) | Indent guides |
| [nvim-colorizer.lua](https://github.com/NvChad/nvim-colorizer.lua) | Inline color previews |
| [noice.nvim](https://github.com/folke/noice.nvim) + [nvim-notify](https://github.com/rcarriga/nvim-notify) | Command/message/notification UI |
| Theme plugins (13) | catppuccin, nightfox, kanagawa, github-theme, onedarkpro, dracula, tokyonight, adwaita, rose-pine, gruvbox-material, everforest, cyberdream, vscode |

## Disabled Plugins In Repo

These are kept in `nvim/lua/plugins/disabled.lua` but not active:

- `nickjvandyke/opencode.nvim`
- `ThePrimeagen/99`
- `karb94/neoscroll.nvim`
- `kevinhwang91/nvim-bqf`
- `anuvyklack/windows.nvim`

## Language Tooling

| Language | LSP server | Formatter | Linter |
|----------|------------|-----------|--------|
| Lua | `lua_ls` | `stylua` | - |
| Python | `pyright` | `ruff format` | `ruff` |
| TypeScript/JavaScript | `ts_ls` | `prettier` | `eslint_d` |
| Go | `gopls` | `goimports`, `gofumpt` | - |
| Rust | `rust_analyzer` | `rustfmt` | - |
| C/C++ | `clangd` | `clang-format` | - |
| Zig | `zls` | `zig fmt` | - |
| Bash/sh | `bashls` | `shfmt` | `shellcheck` |
| Markdown | `marksman` | `prettier` | - |
| Java | `nvim-jdtls` | `google-java-format` | - |
| TeX/LaTeX | `ltex` | `latexindent` | - |
| R | `r_language_server` | `styler` (`r_styler`) | - |

## Keymaps

- Built-in Neovim LSP defaults are available on attach (`K`, `grr`, etc.).
- Custom LSP goto keymaps: `gd`, `gD`, `gy`.
- Full key reference: [`nvim/keymaps.md`](../nvim/keymaps.md).

## Debug Adapters

| Language | Adapter |
|----------|---------|
| Python | `debugpy` |
| Go | `delve` |
| JavaScript/TypeScript | `vscode-js` (`pwa-node`) |
| C/C++/Rust | `codelldb` |
| Java | `java-debug-adapter` + `java-test` |

Global debug toggles:

- `<leader>dtj` toggles Python `justMyCode`
- `<leader>dtv` toggles loading `.vscode/launch.json`

## Theme Picker

13 themes are available through `<leader>st`.

Selected theme is persisted in `~/.local/share/nvim/theme.txt`.

## Core Options

From `nvim/lua/config/options.lua`:

| Option | Value | Note |
|--------|-------|------|
| Line numbers | relative | absolute + relative enabled |
| Tab width | 4 spaces | `expandtab` enabled |
| Undo | persistent | survives restarts |
| Search | smart case | `ignorecase` + `smartcase` |
| Leader | `Space` | |
| Local leader | `\` | |
| Scroll offset | 8 | |
| Mouse | enabled | |
| Wrap | enabled | `linebreak` enabled |
| Global statusline | yes | `laststatus=3` |

## Directory Structure

```text
nvim/
├── init.lua                 # Entry point, bootstraps Lazy.nvim
├── keymaps.md               # Full keybinding reference
├── lua/
│   ├── config/
│   │   ├── init.lua         # Loads options, keymaps, autocmds, diagnostics
│   │   ├── options.lua      # Core vim options
│   │   ├── keymaps.lua      # Non-plugin keybindings
│   │   ├── autocmds.lua     # User commands/autocmds (markdown PDF, trim whitespace)
│   │   ├── diagnostics.lua  # Diagnostic behavior + keymaps
│   │   └── theme_picker.lua # Persistent theme selection
│   └── plugins/
│       ├── lsp.lua          # LSP + Mason + nvim-cmp
│       ├── ai.lua           # Copilot + CopilotChat
│       ├── format.lua       # Conform formatters
│       ├── lint.lua         # nvim-lint setup
│       ├── tools.lua        # Neo-tree, Flash, Harpoon, markdown tools, etc.
│       ├── git.lua          # Fugitive, gitsigns, LazyGit, Diffview
│       ├── telescope.lua    # Telescope pickers + extensions
│       ├── treesitter.lua   # Treesitter + textobjects
│       ├── ui.lua           # Themes, lualine, indent guides, noice
│       ├── debug.lua        # DAP config and keymaps
│       ├── java.lua         # JDTLS setup with DAP integration
│       ├── snippets.lua     # LuaSnip + snippets
│       └── disabled.lua     # Installed but disabled plugins
```

## Java Setup

Java uses [nvim-jdtls](https://github.com/mfussenegger/nvim-jdtls) (not `lspconfig`) for full Eclipse JDT behavior:

- starts/attaches on Java filetypes
- integrates Java debug/test bundles when installed via Mason
- keymaps: `<leader>jo`, `<leader>jev`, `<leader>jec`, `<leader>jem`, `<leader>jtm`, `<leader>jtc`
