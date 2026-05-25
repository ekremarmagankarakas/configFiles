return {
	----------------------------------------------------------------------
	-- Which Key
	----------------------------------------------------------------------
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {},
		keys = {
			{
				"<leader>?l",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Which-key: buffer local keymaps",
			},
			{
				"<leader>?g",
				function()
					require("which-key").show({ global = true })
				end,
				desc = "Which-key: global keymaps",
			},
		},
		config = function(_, opts)
			local wk = require("which-key")
			wk.setup(opts)

			wk.add({
				{ "<leader>a", group = "ai" },
				{ "<leader>d", group = "debug" },
				{ "<leader>f", group = "find" },
				{ "<leader>g", group = "git" },
				{ "<leader>h", group = "harpoon" },
				{ "<leader>j", group = "java" },
				{ "<leader>l", group = "lsp" },
				{ "<leader>m", group = "markdown" },
				{ "<leader>n", group = "files" },
				{ "<leader>s", group = "settings" },
				{ "<leader>w", group = "windows" },
				{ "<leader>?", group = "whichkey" },
			})
		end,
	},
}
