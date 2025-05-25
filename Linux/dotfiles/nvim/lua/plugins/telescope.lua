return {
	{
		"nvim-telescope/telescope-ui-select.nvim",
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
			vim.keymap.set("n", "<leader>fo", builtin.oldfiles, {})
			vim.keymap.set("n", "<leader>fa", function()
				require("telescope.builtin").find_files({
					prompt_title = "Search in Selected Dirs",
					find_command = {
						"find",
						vim.fn.expand("~/Workspace"),
						vim.fn.expand("~/Northeastern"),
						vim.fn.expand("~/Work"),
						vim.fn.expand("~/.config/nvim"),
						vim.fn.expand("~/.config/kitty"),
						vim.fn.expand("~/.config/picom"),
						vim.fn.expand("~/.config/rofi"),
						vim.fn.expand("~/.config/starship"),
						vim.fn.expand("~/.config/i3"),
						vim.fn.expand("~/.config/i3ctl"),
						vim.fn.expand("~/.config/securegit"),
						"-type",
						"f",
						"-not",
						"-path",
						"*/node_modules/*",
						"-not",
						"-path",
						"*/venv/*",
						"-not",
						"-path",
						"*/.git/*",
						"-not",
						"-path",
						"*/__pycache__/*",
					},
					hidden = true,
					no_ignore = true,
				})
			end, {})

			require("telescope").load_extension("ui-select")
		end,
	},
}
