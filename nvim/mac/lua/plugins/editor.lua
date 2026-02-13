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
	-- Markview
	----------------------------------------------------------------------
	{
		"OXY2DEV/markview.nvim",
		main = "markview",
		cmd = { "Markview" },
		keys = {
			{ "<leader>sm", "<cmd>Markview toggle<cr>", silent = true, desc = "Markview: toggle" },
		},
		opts = {},
	},

	----------------------------------------------------------------------
	-- Todo Comments
	----------------------------------------------------------------------
	{
		"folke/todo-comments.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{
				"]t",
				function()
					require("todo-comments").jump_next()
				end,
				desc = "Todo: next comment",
			},
			{
				"[t",
				function()
					require("todo-comments").jump_prev()
				end,
				desc = "Todo: prev comment",
			},
			{ "<leader>fT", "<cmd>TodoTelescope<cr>", desc = "Find: todo comments" },
		},
		opts = {},
	},

	----------------------------------------------------------------------
	-- Trouble (better diagnostics/quickfix list)
	----------------------------------------------------------------------
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		cmd = "Trouble",
		keys = {
			{ "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Trouble: diagnostics" },
			{ "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Trouble: buffer diagnostics" },
			{ "<leader>xl", "<cmd>Trouble loclist toggle<cr>", desc = "Trouble: location list" },
			{ "<leader>xq", "<cmd>Trouble qflist toggle<cr>", desc = "Trouble: quickfix list" },
			{ "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Trouble: symbols" },
		},
		opts = {},
	},

	----------------------------------------------------------------------
	-- Flash (enhanced motions)
	----------------------------------------------------------------------
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash: jump",
			},
			{
				"S",
				mode = { "n", "x", "o" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash: treesitter",
			},
			{
				"r",
				mode = "o",
				function()
					require("flash").remote()
				end,
				desc = "Flash: remote",
			},
			{
				"R",
				mode = { "o", "x" },
				function()
					require("flash").treesitter_search()
				end,
				desc = "Flash: treesitter search",
			},
		},
		opts = {},
	},
}
