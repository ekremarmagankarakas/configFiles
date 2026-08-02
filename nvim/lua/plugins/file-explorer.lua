return {
	----------------------------------------------------------------------
	-- Oil (edit filesystem as a buffer)
	----------------------------------------------------------------------
	{
		"stevearc/oil.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		lazy = false,
		keys = {
			{ "-", "<cmd>Oil<cr>", desc = "Oil: open parent directory" },
			{ "<leader>n", "<cmd>Oil<cr>", desc = "Oil: open parent directory" },
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
		},
	},
}
