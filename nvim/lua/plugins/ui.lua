return {
	----------------------------------------------------------------------
	-- Install Themes
	----------------------------------------------------------------------
	{ "catppuccin/nvim", name = "catppuccin", lazy = true, priority = 1000 },
	{ "projekt0n/github-nvim-theme", name = "github-theme", lazy = true, priority = 1000 },
	{ "Mofiqul/vscode.nvim", lazy = true, priority = 1000 },
	-- { "Mofiqul/dracula.nvim", lazy = true, priority = 1000 },
	-- { "folke/tokyonight.nvim", lazy = true, priority = 1000 },
	-- { "Mofiqul/adwaita.nvim", lazy = true, priority = 1000 },
	-- { "rose-pine/neovim", lazy = true, priority = 1000 },

	----------------------------------------------------------------------
	-- Indent Blankline
	----------------------------------------------------------------------
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {
			scope = {
				enabled = true,
				show_start = true,
				show_end = false,
			},
		},
	},

	----------------------------------------------------------------------
	-- Lualine
	----------------------------------------------------------------------
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			options = {
				theme = "auto",
				globalstatus = true,
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = { { "filename", path = 1 } },
				lualine_x = { "filetype" },
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
		},
	},
}
