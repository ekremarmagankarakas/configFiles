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
| [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim) | File explorer sidebar |
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) + fzf-native + ui-select | Fuzzy finder |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) + textobjects + autotag | Parsing, highlighting, text objects |
| [flash.nvim](https://github.com/folke/flash.nvim) | Motion enhancements |
| [which-key.nvim](https://github.com/folke/which-key.nvim) | Keymap hints |
| [harpoon](https://github.com/ThePrimeagen/harpoon) (v2) | Quick file marks/navigation |
| [nvim-autopairs](https://github.com/windwp/nvim-autopairs) | Auto-pairs |
| [mkdnflow.nvim](https://github.com/jakewvincent/mkdnflow.nvim) | Markdown link/todo workflow |
| [vimtex](https://github.com/lervag/vimtex) | TeX/LaTeX workflow |
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Git hunks/signs in buffer |
| [lazygit.nvim](https://github.com/kdheepak/lazygit.nvim) | LazyGit TUI integration |
| [diffview.nvim](https://github.com/sindrets/diffview.nvim) | Diff and merge UI |
| [copilot.lua](https://github.com/zbirenbaum/copilot.lua) | Copilot suggestions (auto-trigger off by default) |
| [CopilotChat.nvim](https://github.com/CopilotC-Nvim/CopilotChat.nvim) | Copilot chat/actions |
| [nvim-dap](https://github.com/mfussenegger/nvim-dap) + UI + virtual text | Debugging framework |
| [nvim-dap-python](https://github.com/mfussenegger/nvim-dap-python) | Python debugger |
| [nvim-dap-go](https://github.com/leoluz/nvim-dap-go) | Go debugger |
| [nvim-dap-vscode-js](https://github.com/mxsdev/nvim-dap-vscode-js) | JS/TS debug adapter |
| [nvim-dap-lldb](https://github.com/julianolf/nvim-dap-lldb) | C/C++/Rust LLDB adapter |
| [nvim-jdtls](https://github.com/mfussenegger/nvim-jdtls) | Java LSP + DAP/test integration |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | Statusline |
| [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) | Indent guides with scope highlight |
| [noice.nvim](https://github.com/folke/noice.nvim) + [nvim-notify](https://github.com/rcarriga/nvim-notify) | Command/message/notification UI |
| Theme plugins (13) | catppuccin, nightfox, kanagawa, github-theme, onedarkpro, dracula, tokyonight, adwaita, rose-pine, gruvbox-material, everforest, cyberdream, vscode |

## Removed Plugins

These have been removed from the config entirely (not loaded):

- `nickjvandyke/opencode.nvim`
- `ThePrimeagen/99`
- `karb94/neoscroll.nvim`
- `kevinhwang91/nvim-bqf`
- `anuvyklack/windows.nvim`
- `tpope/vim-fugitive`
- `mbbill/undotree`
- `folke/todo-comments.nvim`
- `3rd/image.nvim`
- `kylechui/nvim-surround`
- `OXY2DEV/markview.nvim`

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
| Java | `java-debug-adapter` + `java-test` |

Debug toggles:
- `<leader>dtj` — toggle Python `justMyCode`
- `<leader>dtv` — toggle loading `.vscode/launch.json`

## Theme Picker

13 themes available via `<leader>st`. Selected theme is persisted in `~/.local/share/nvim/theme.txt`.

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
│       ├── tools.lua        # Neo-tree, Flash, Harpoon, markview, mkdnflow, vimtex
│       ├── git.lua          # Gitsigns, LazyGit, Diffview
│       ├── telescope.lua    # Telescope pickers + extensions
│       ├── treesitter.lua   # Treesitter + textobjects + autotag
│       ├── ui.lua           # Themes, lualine, indent-blankline, noice
│       ├── debug.lua        # DAP config and keymaps
│       ├── java.lua         # JDTLS setup with DAP integration
│       └── snippets.lua     # LuaSnip + friendly-snippets
```

## Java Setup

Java uses [nvim-jdtls](https://github.com/mfussenegger/nvim-jdtls) (not `lspconfig`) for full Eclipse JDT behavior:

- Starts/attaches on Java filetypes via autocmd
- Per-project workspace isolation in `~/.local/share/nvim/jdtls-workspace/`
- Integrates `java-debug-adapter` and `java-test` bundles when installed via Mason
- Keymaps (Java buffers only):

| Key | Action |
|-----|--------|
| `<leader>jo` | Organize imports |
| `<leader>jev` | Extract variable |
| `<leader>jec` | Extract constant |
| `<leader>jem` | Extract method |
| `<leader>jtm` | Test nearest method |
| `<leader>jtc` | Test class |
