# Neovim Configuration

Both macOS and Linux have Neovim configs built on [Lazy.nvim](https://github.com/folke/lazy.nvim). The macOS config (`nvim/mac/`) is the primary/more complete one. The Linux config (`nvim/linux/`) follows a similar structure but is an earlier iteration.

## Plugin Manager

[Lazy.nvim](https://github.com/folke/lazy.nvim) -- plugins are lazy-loaded for fast startup. Open Neovim and run `:Lazy` to see plugin status.

## Plugin Overview

### LSP & Completion

| Plugin | Purpose |
|--------|---------|
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | LSP client configurations |
| [Mason](https://github.com/mason-org/mason.nvim) | LSP/DAP/formatter installer |
| [mason-tool-installer](https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim) | Auto-install tools via Mason |
| [conform.nvim](https://github.com/stevearc/conform.nvim) | Formatting engine |
| [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) | Autocompletion |

#### Configured Language Servers

| Language | Server | Formatter |
|----------|--------|-----------|
| Lua | lua_ls | stylua |
| Python | pyright | ruff |
| TypeScript/JavaScript | ts_ls | eslint_d, prettier |
| Go | gopls | goimports, gofumpt |
| Rust | rust_analyzer | rustfmt |
| C/C++ | clangd | clang-format |
| Zig | zls | zigfmt |
| Bash | bashls | shfmt |
| Markdown | marksman, ltex | prettier |
| Java | jdtls | google-java-format |
| LaTeX | ltex | latexindent |
| R | r_language_server | styler |

### Editor

| Plugin | Purpose |
|--------|---------|
| [Neo-tree](https://github.com/nvim-neo-tree/neo-tree.nvim) | File explorer sidebar |
| [Telescope](https://github.com/nvim-telescope/telescope.nvim) | Fuzzy finder (files, grep, buffers, git) |
| [Treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Syntax highlighting + text objects |
| [Flash](https://github.com/folke/flash.nvim) | Quick navigation/motions |
| [Trouble](https://github.com/folke/trouble.nvim) | Diagnostics list |
| [Todo Comments](https://github.com/folke/todo-comments.nvim) | Highlight and search TODO/FIXME/HACK |
| [Markview](https://github.com/OXY2DEV/markview.nvim) | In-editor markdown rendering |

### Git

| Plugin | Purpose |
|--------|---------|
| [vim-fugitive](https://github.com/tpope/vim-fugitive) | Git commands inside Neovim |
| [gitsigns](https://github.com/lewis6991/gitsigns.nvim) | Git signs in the gutter, hunk staging |
| [LazyGit](https://github.com/kdheepak/lazygit.nvim) | Full-screen git UI |
| [Diffview](https://github.com/sindrets/diffview.nvim) | Side-by-side diffs and merge conflict resolution |
| [Copilot](https://github.com/zbirenbaum/copilot.lua) | AI code suggestions |

### Debugging (DAP)

| Plugin | Purpose |
|--------|---------|
| [nvim-dap](https://github.com/mfussenegger/nvim-dap) | Debug Adapter Protocol client |
| [nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui) | Debugger UI (variables, breakpoints, console) |
| [nvim-dap-virtual-text](https://github.com/theHamsta/nvim-dap-virtual-text) | Inline variable values during debugging |

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

### Tools

| Plugin | Purpose |
|--------|---------|
| [Harpoon 2](https://github.com/ThePrimeagen/harpoon/tree/harpoon2) | Quick file switching (mark up to 4 files) |
| [UndoTree](https://github.com/mbbill/undotree) | Visual undo history |
| [Which-key](https://github.com/folke/which-key.nvim) | Keybinding hints popup |
| [nvim-surround](https://github.com/kylechui/nvim-surround) | Add/change/delete surrounding pairs |
| [autopairs](https://github.com/windwp/nvim-autopairs) | Auto-close brackets and quotes |
| [nvim-colorizer](https://github.com/NvChad/nvim-colorizer.lua) | Inline color preview |
| [VimTeX](https://github.com/lervag/vimtex) | LaTeX editing and compilation |
| [windows.nvim](https://github.com/anuvyklack/windows.nvim) | Window maximize toggle |

### UI

| Plugin | Purpose |
|--------|---------|
| [Lualine](https://github.com/nvim-lualine/lualine.nvim) | Statusline (shows mode, branch, diagnostics, LSP, Copilot status) |
| [indent-blankline](https://github.com/lukas-reineke/indent-blankline.nvim) | Indentation guides |
| [Noice](https://github.com/folke/noice.nvim) | Replaces cmdline, messages, and notifications with floating UI |
| [Neoscroll](https://github.com/karb94/neoscroll.nvim) | Smooth scrolling |

### Theme Picker

12 themes are installed and available through a persistent picker (`<leader>st`):

catppuccin, nightfox, kanagawa, github-theme, onedarkpro, dracula, tokyonight, adwaita, rose-pine, gruvbox-material, everforest, cyberdream, vscode

Your selection is saved to `~/.local/share/nvim/theme.txt` and persists across sessions.

## Core Options

From `nvim/mac/lua/config/options.lua`:

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

## Directory Structure (macOS)

```
nvim/mac/
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
│       ├── lsp.lua          # LSP, Mason, conform, cmp
│       ├── editor.lua       # Neo-tree, Telescope, Treesitter, etc.
│       ├── git.lua          # Fugitive, gitsigns, Copilot, LazyGit
│       ├── telescope.lua    # Telescope config and pickers
│       ├── treesitter.lua   # Treesitter + text objects
│       ├── tools.lua        # Harpoon, surround, undotree, etc.
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
