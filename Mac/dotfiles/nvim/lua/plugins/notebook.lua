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
			-- Kernel lifecycle
			{ "<leader>mi", ":MoltenInit<CR>", desc = "Molten Init Kernel" },
			{ "<leader>mK", ":MoltenRestart<CR>", desc = "Molten Restart Kernel" },
			{ "<leader>md", ":MoltenDeinit<CR>", desc = "Molten Deinit Kernel" },

			-- First-time evaluation (creates cells)
			{ "<leader>me", ":MoltenEvaluateLine<CR>", desc = "Molten Evaluate Line" },
			{
				"<leader>me",
				":<C-u>MoltenEvaluateVisual<CR>gv",
				mode = "v",
				desc = "Molten Evaluate Selection",
			},
			{ "<leader>ma", ":MoltenEvaluateOperator<CR>", desc = "Molten Evaluate Operator" },

			-- Re-running cells
			{ "<leader>mr", ":MoltenReevaluateCell<CR>", desc = "Molten Re-run Cell" },
			{ "<leader>mR", ":MoltenReevaluateAll<CR>", desc = "Molten Re-run All Cells" },

			-- Output control
			{ "<leader>mo", ":MoltenShowOutput<CR>", desc = "Molten Show Output" },
			{ "<leader>mh", ":MoltenHideOutput<CR>", desc = "Molten Hide Output" },
			{ "<leader>mx", ":MoltenDelete<CR>", desc = "Molten Delete Cell" },
			{ "<leader>mO", ":noautocmd MoltenEnterOutput<CR>", desc = "Molten Enter Output" },

			-- Navigation
			{ "<leader>mn", ":MoltenNext<CR>", desc = "Molten Next Cell" },
			{ "<leader>mp", ":MoltenPrev<CR>", desc = "Molten Previous Cell" },

			-- Info and utilities
			{ "<leader>mI", ":MoltenInfo<CR>", desc = "Molten Info" },
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
			max_width = 100,
			max_height = 12,
			window_overlap_clear_enabled = true,
		},
	},
}
