return {
	----------------------------------------------------------------------
	-- Install Themes
	----------------------------------------------------------------------
	{ "catppuccin/nvim", name = "catppuccin", lazy = false, priority = 1000 },
	{ "EdenEast/nightfox.nvim", lazy = false, priority = 1000 },
	{ "rebelot/kanagawa.nvim", lazy = false, priority = 1000 },
	{ "projekt0n/github-nvim-theme", name = "github-theme", lazy = false, priority = 1000 },
	{ "olimorris/onedarkpro.nvim", lazy = false, priority = 1000 },
    { "Mofiqul/dracula.nvim", lazy = false, priority = 1000 },
    { "folke/tokyonight.nvim", lazy = false, priority = 1000 },
    { "Mofiqul/adwaita.nvim", lazy = false, priority = 1000 },
    { "rose-pine/neovim", lazy = false, priority = 1000 },
    { "sainnhe/gruvbox-material", lazy = false, priority = 1000 },
    { "sainnhe/everforest", lazy = false, priority = 1000 },
    { "scottmckendry/cyberdream.nvim", lazy = false, priority = 1000 },

	----------------------------------------------------------------------
	-- Load Current Theme
	----------------------------------------------------------------------
	{
        "Mofiqul/vscode.nvim",
        lazy = false,
		priority = 1000,
		config = function()
			local theme_state = require("config.theme_state")
			vim.cmd.colorscheme(theme_state.load())
		end,
	},

	----------------------------------------------------------------------
	-- Lualine
	----------------------------------------------------------------------
	{
		"nvim-lualine/lualine.nvim",
		config = function()
			require("lualine").setup({
				options = {
					theme = "auto",
				},
			})
		end,
	},

	----------------------------------------------------------------------
	-- Indent Blankline
	----------------------------------------------------------------------
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		---@module "ibl"
		---@type ibl.config
		opts = {},
	},
}
