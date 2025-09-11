return {
  {
    "lervag/vimtex",
    ft = { "tex" },
    init = function()
      vim.g.vimtex_view_method = "zathura"            -- use zathura
      vim.g.vimtex_compiler_method = "latexmk"        -- default, explicit here
      vim.g.vimtex_quickfix_mode = 0                  -- don't auto-open quickfix on warnings
      vim.g.vimtex_compiler_progname = "nvr"          -- for inverse search (requires neovim-remote)

      -- Put all generated files (including PDF) into ./out
      vim.g.vimtex_compiler_latexmk = {
        continuous = 1,
        out_dir = "out",
        options = { "-pdf", "-interaction=nonstopmode", "-synctex=1" },
      }
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      ensure_installed = { "latex", "bibtex" },
      highlight = { enable = true },
    },
  },
}

