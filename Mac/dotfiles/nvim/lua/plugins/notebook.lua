return {
	-- Core: Execute code cells (Jupyter inside Neovim)
	{
		"benlubas/molten-nvim",
		version = "^1.0.0",
		build = ":UpdateRemotePlugins",
		init = function()
			vim.g.molten_image_provider = "image.nvim"
			vim.g.molten_output_win_max_height = 20
		end,
		keys = {
			-- Fenced block helpers
			{
				"<leader>mb",
				function()
					vim.cmd([[silent! ?^```]])
					vim.cmd("normal! j")
					vim.cmd("normal! V")
					vim.cmd([[silent! /^```]])
					vim.cmd("normal! k")
				end,
				desc = "Molten: select fenced block",
			},
			{
				"<leader>mc",
				function()
					vim.cmd([[silent! ?^```]])
					vim.cmd("normal! j")
					vim.cmd("normal! V")
					vim.cmd([[silent! /^```]])
					vim.cmd("normal! k")
					vim.cmd("'<,'>MoltenEvaluateVisual")
					vim.cmd("normal! <Esc>")
				end,
				desc = "Molten: run fenced block",
			},

			-- Kernel lifecycle
			{ "<leader>mi", "<cmd>MoltenInit<cr>", desc = "Molten: init kernel" },
			{ "<leader>mK", "<cmd>MoltenRestart<cr>", desc = "Molten: restart kernel" },
			{ "<leader>md", "<cmd>MoltenDeinit<cr>", desc = "Molten: deinit kernel" },

			-- First-time evaluation (creates cells)
			{ "<leader>me", "<cmd>MoltenEvaluateLine<cr>", desc = "Molten: evaluate line" },
			{
				"<leader>me",
				":<C-u>MoltenEvaluateVisual<CR>gv",
				mode = "v",
				desc = "Molten Evaluate Selection",
			},
			{ "<leader>ma", "<cmd>MoltenEvaluateOperator<cr>", desc = "Molten: evaluate operator" },

			-- Re-running cells
			{ "<leader>mr", "<cmd>MoltenReevaluateCell<cr>", desc = "Molten: re-run cell" },
			{ "<leader>mR", "<cmd>MoltenReevaluateAll<cr>", desc = "Molten: re-run all cells" },

			-- Output control
			{ "<leader>mo", "<cmd>MoltenShowOutput<cr>", desc = "Molten: show output" },
			{ "<leader>mh", "<cmd>MoltenHideOutput<cr>", desc = "Molten: hide output" },
			{ "<leader>mx", "<cmd>MoltenDelete<cr>", desc = "Molten: delete cell" },
			{ "<leader>mO", ":noautocmd MoltenEnterOutput<CR>", desc = "Molten Enter Output" },

			-- Navigation
			{ "<leader>mn", "<cmd>MoltenNext<cr>", desc = "Molten: next cell" },
			{ "<leader>mp", "<cmd>MoltenPrev<cr>", desc = "Molten: previous cell" },

			-- Info and utilities
			{ "<leader>mI", "<cmd>MoltenInfo<cr>", desc = "Molten: info" },
		},
	},

	-- Open .ipynb files as markdown notebooks
	{
		"GCBallesteros/jupytext.nvim",
		config = true,
		lazy = false,
	},

	-- Image support for plots
	{
		"3rd/image.nvim",
		opts = {
			backend = "kitty",
		},
	},
}
