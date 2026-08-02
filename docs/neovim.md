# Neovim Configuration

A single Neovim config shared across macOS and Linux, built on [Lazy.nvim](https://github.com/folke/lazy.nvim).

## Plugin Manager

[Lazy.nvim](https://github.com/folke/lazy.nvim) lazy-loads plugins for fast startup. Use `:Lazy` to inspect status.

## Active Plugins

| Plugin | Purpose |
|--------|---------|
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | LSP client configuration |
| [mason.nvim](https://github.com/mason-org/mason.nvim) | Install LSP/DAP/formatters/linters |
| [mason-tool-installer.nvim](https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim) | Auto-install Mason tools |
| [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) + sources | Completion engine |
| [LuaSnip](https://github.com/L3MON4D3/LuaSnip) + [friendly-snippets](https://github.com/rafamadriz/friendly-snippets) | Snippets |
| [conform.nvim](https://github.com/stevearc/conform.nvim) | Formatting |
| [nvim-lint](https://github.com/mfussenegger/nvim-lint) | Linting |
| [oil.nvim](https://github.com/stevearc/oil.nvim) | Edit filesystem as buffer |
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) + fzf-native + ui-select | Fuzzy finder |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) + textobjects + autotag | Parsing, highlighting, text objects |
| [flash.nvim](https://github.com/folke/flash.nvim) | Motion enhancements |
| [which-key.nvim](https://github.com/folke/which-key.nvim) | Keymap hints |
| [harpoon](https://github.com/ThePrimeagen/harpoon) (v2) | Quick file marks/navigation |
| [nvim-autopairs](https://github.com/windwp/nvim-autopairs) | Auto-pairs |
| [mkdnflow.nvim](https://github.com/jakewvincent/mkdnflow.nvim) | Markdown link/todo workflow |
| [vimtex](https://github.com/lervag/vimtex) | TeX/LaTeX workflow |
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Git hunks/signs in buffer |
| [diffview.nvim](https://github.com/sindrets/diffview.nvim) | Diff and merge UI |
| [copilot.lua](https://github.com/zbirenbaum/copilot.lua) | Copilot suggestions (auto-trigger off by default) |
| [CopilotChat.nvim](https://github.com/CopilotC-Nvim/CopilotChat.nvim) | Copilot chat/actions |
| [nvim-dap](https://github.com/mfussenegger/nvim-dap) + UI + virtual text | Debugging framework |
| [nvim-dap-python](https://github.com/mfussenegger/nvim-dap-python) | Python debugger |
| [nvim-dap-go](https://github.com/leoluz/nvim-dap-go) | Go debugger |
| [nvim-dap-vscode-js](https://github.com/mxsdev/nvim-dap-vscode-js) | JS/TS debug adapter |
| [nvim-dap-lldb](https://github.com/julianolf/nvim-dap-lldb) | C/C++/Rust LLDB adapter |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | Statusline |
| [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) | Indent guides with scope highlight |
| Theme plugins (3 active) | catppuccin, github-theme, vscode.nvim (dracula, tokyonight, adwaita, rose-pine present but commented out) |

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
| TeX/LaTeX | `ltex` | `tex-fmt` | - |
| R | `r_language_server` | `styler` (`r_styler`) | - |
| PHP | `intelephense` | `prettier` | - |
| CSS/SCSS/LESS | `cssls` | `prettier` | - |
| HTML | `html` | `prettier` | - |
| SQL | `sqls` | `sqlfmt` | - |

ESLint linting is skipped automatically when no ESLint config file is found in the project.

Python venv is auto-detected from `$VIRTUAL_ENV` or `.venv/` in the project root.

## Keymaps

- Built-in Neovim 0.11+ LSP defaults apply on attach (`K`, `grr`, `grn`, `gra`, `gd`, `gD`, etc.)
- `gy` → go to type definition (custom, not a Neovim default)
- `<leader>lf` → format file (conform)
- `<leader>ll` → run linters manually
- Full key reference: [`nvim/keymaps.md`](../nvim/keymaps.md)

## Debug Adapters

| Language | Adapter |
|----------|---------|
| Python | `debugpy` |
| Go | `delve` |
| JavaScript/TypeScript | `vscode-js` (`pwa-node`) |
| C/C++/Rust | `codelldb` |

Debug toggles:
- `<leader>dtj` — toggle Python `justMyCode`
- `<leader>dtv` — toggle loading `.vscode/launch.json`

## Theme Picker

`<leader>st` opens a Telescope picker over every colorscheme currently loadable (the 3 active theme plugins plus Neovim's built-in colorschemes). Selected theme is persisted in `~/.local/share/nvim/theme.txt`.

## Core Options

| Option | Value |
|--------|-------|
| Line numbers | absolute + relative |
| Tab width | 4 spaces (`expandtab`) |
| Undo | persistent (survives restarts) |
| Search | smart case (`ignorecase` + `smartcase`) |
| Leader | `Space` |
| Local leader | `\` |
| Scroll offset | 8 lines |
| Mouse | enabled |
| Wrap | enabled (`linebreak`) |
| Virtual text diagnostics | off by default (toggle `<leader>lee`) |
