return {
	----------------------------------------------------------------------
	-- Neo-Tree
	----------------------------------------------------------------------
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		main = "neo-tree",
		keys = {
			{ "<leader>nn", "<cmd>Neotree filesystem reveal left<cr>", silent = true, desc = "Neo-tree: reveal" },
			{ "<leader>nt", "<cmd>Neotree toggle<cr>", silent = true, desc = "Neo-tree: toggle" },
		},
		opts = {
			filesystem = {
				filtered_items = {
					visible = true,
					hide_dotfiles = false,
					hide_gitignored = true,
				},
			},
			window = {
				mappings = {
					-- "O" for "Open Externally" (PDFs, Browsers, etc.)
					["O"] = function(state)
						local node = state.tree:get_node()
						local path = node:get_id()
						vim.ui.open(path)
					end,
				},
			},
		},
	},

	----------------------------------------------------------------------
	-- Oil (edit filesystem as a buffer)
	----------------------------------------------------------------------
	{
		"stevearc/oil.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		lazy = false,
		keys = {
			{ "-", "<cmd>Oil<cr>", desc = "Oil: open parent directory" },
			{ "<leader>no", "<cmd>Oil<cr>", desc = "Oil: open parent directory" },
			{
				"<leader>nf",
				function()
					require("oil").toggle_float()
				end,
				desc = "Oil: toggle float",
			},
		},
		opts = {
			default_file_explorer = true,
			columns = { "icon" },
			delete_to_trash = true,
			skip_confirm_for_simple_edits = true,
			watch_for_changes = true,
			view_options = {
				show_hidden = true,
			},
			float = {
				border = "rounded",
				max_width = 0.6,
				max_height = 0.8,
			},
		},
	},
}
