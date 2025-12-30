return {
	----------------------------------------------------------------------
	-- Git Fugitive
	----------------------------------------------------------------------
	{
		"tpope/vim-fugitive",
	},

	----------------------------------------------------------------------
	-- Git Signs
	----------------------------------------------------------------------
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()

			vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", {})
			vim.keymap.set("n", "<leader>gb", ":Gitsigns toggle_current_line_blame<CR>", {})
		end,
	},

	----------------------------------------------------------------------
	-- Copilot
	----------------------------------------------------------------------
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				suggestion = {
					auto_trigger = false,
					keymap = {
						accept = "<M-y>",
						next = "<M-]>",
						prev = "<M-[>",
						dismiss = "<C-]>",
					},
				},
				panel = { enabled = false },
			})
		end,
	},

	----------------------------------------------------------------------
	-- LazyGit
	----------------------------------------------------------------------
	{
		"kdheepak/lazygit.nvim",
		lazy = true,
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		-- optional for floating window border decoration
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		-- setting the keybinding for LazyGit with 'keys' is recommended in
		-- order to load the plugin when the command is run for the first time
		keys = {
			{ "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
		},
	},

	----------------------------------------------------------------------
	-- DiffView
	----------------------------------------------------------------------
	{
		"sindrets/diffview.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		cmd = {
			"DiffviewOpen",
			"DiffviewClose",
			"DiffviewToggleFiles",
			"DiffviewFocusFiles",
			"DiffviewRefresh",
			"DiffviewFileHistory",
		},
		keys = {
			{ "<leader>gdo", "<cmd>DiffviewOpen<cr>", desc = "Open Diffview" },
			{ "<leader>gdc", "<cmd>DiffviewClose<cr>", desc = "Close Diffview" },
			{ "<leader>gdh", "<cmd>DiffviewFileHistory<cr>", desc = "File History (all)" },
			{ "<leader>gdf", "<cmd>DiffviewFileHistory %<cr>", desc = "File History (current)" },
			{ "<leader>gdt", "<cmd>DiffviewToggleFiles<cr>", desc = "Toggle File Panel" },
		},
		config = function()
			require("diffview").setup({
				diff_binaries = false,
				enhanced_diff_hl = false,
				use_icons = true,
				show_help_hints = true,
				watch_index = true,

				icons = {
					folder_closed = "",
					folder_open = "",
				},

				signs = {
					fold_closed = "",
					fold_open = "",
					done = "✓",
				},

				view = {
					default = {
						layout = "diff2_horizontal",
						winbar_info = false,
					},
					merge_tool = {
						layout = "diff3_horizontal",
						disable_diagnostics = true,
						winbar_info = true,
					},
					file_history = {
						layout = "diff2_horizontal",
						winbar_info = false,
					},
				},

				file_panel = {
					listing_style = "tree",
					tree_options = {
						flatten_dirs = true,
						folder_statuses = "only_folded",
					},
					win_config = {
						position = "left",
						width = 35,
						win_opts = {},
					},
				},

				file_history_panel = {
					log_options = {
						git = {
							single_file = {
								diff_merges = "combined",
							},
							multi_file = {
								diff_merges = "first-parent",
							},
						},
					},
					win_config = {
						position = "bottom",
						height = 16,
						win_opts = {},
					},
				},

				commit_log_panel = {
					win_config = {
						win_opts = {},
					},
				},

				default_args = {
					DiffviewOpen = {},
					DiffviewFileHistory = {},
				},

				hooks = {
					diff_buf_read = function(bufnr)
						-- Change local options in diff buffers
						vim.opt_local.wrap = false
						vim.opt_local.list = false
						vim.opt_local.relativenumber = false
						vim.opt_local.cursorline = false
					end,
					view_opened = function(view)
						-- Highlight when a view is opened
						vim.notify("DiffView opened", vim.log.levels.INFO)
					end,
				},

				keymaps = {
					disable_defaults = false,
					view = {
						-- Standard mappings
						{ "n", "<tab>", "<cmd>DiffviewFocusFiles<cr>", { desc = "Focus file panel" } },
						{ "n", "gf", "<cmd>DiffviewToggleFiles<cr>", { desc = "Toggle file panel" } },
						{
							"n",
							"[x",
							"<cmd>lua require('diffview.actions').prev_conflict()<cr>",
							{ desc = "Prev conflict" },
						},
						{
							"n",
							"]x",
							"<cmd>lua require('diffview.actions').next_conflict()<cr>",
							{ desc = "Next conflict" },
						},
						-- Conflict resolution (only active in merge views)
						{
							"n",
							"<leader>dco",
							"<cmd>lua require('diffview.actions').conflict_choose('ours')<cr>",
							{ desc = "Choose ours" },
						},
						{
							"n",
							"<leader>dct",
							"<cmd>lua require('diffview.actions').conflict_choose('theirs')<cr>",
							{ desc = "Choose theirs" },
						},
						{
							"n",
							"<leader>dcb",
							"<cmd>lua require('diffview.actions').conflict_choose('base')<cr>",
							{ desc = "Choose base" },
						},
						{
							"n",
							"<leader>dca",
							"<cmd>lua require('diffview.actions').conflict_choose('all')<cr>",
							{ desc = "Choose all" },
						},
						{
							"n",
							"dx",
							"<cmd>lua require('diffview.actions').conflict_choose('none')<cr>",
							{ desc = "Delete conflict region" },
						},
					},
					file_panel = {
						{
							"n",
							"j",
							"<cmd>lua require('diffview.actions').next_entry()<cr>",
							{ desc = "Next entry" },
						},
						{
							"n",
							"k",
							"<cmd>lua require('diffview.actions').prev_entry()<cr>",
							{ desc = "Prev entry" },
						},
						{
							"n",
							"<cr>",
							"<cmd>lua require('diffview.actions').select_entry()<cr>",
							{ desc = "Select entry" },
						},
						{
							"n",
							"o",
							"<cmd>lua require('diffview.actions').select_entry()<cr>",
							{ desc = "Select entry" },
						},
						{
							"n",
							"<2-LeftMouse>",
							"<cmd>lua require('diffview.actions').select_entry()<cr>",
							{ desc = "Select entry" },
						},
						{
							"n",
							"-",
							"<cmd>lua require('diffview.actions').toggle_stage_entry()<cr>",
							{ desc = "Stage/unstage" },
						},
						{
							"n",
							"S",
							"<cmd>lua require('diffview.actions').stage_all()<cr>",
							{ desc = "Stage all" },
						},
						{
							"n",
							"U",
							"<cmd>lua require('diffview.actions').unstage_all()<cr>",
							{ desc = "Unstage all" },
						},
						{
							"n",
							"X",
							"<cmd>lua require('diffview.actions').restore_entry()<cr>",
							{ desc = "Restore entry" },
						},
						{
							"n",
							"L",
							"<cmd>lua require('diffview.actions').open_commit_log()<cr>",
							{ desc = "Open commit log" },
						},
						{
							"n",
							"zo",
							"<cmd>lua require('diffview.actions').open_fold()<cr>",
							{ desc = "Open fold" },
						},
						{
							"n",
							"zc",
							"<cmd>lua require('diffview.actions').close_fold()<cr>",
							{ desc = "Close fold" },
						},
						{
							"n",
							"za",
							"<cmd>lua require('diffview.actions').toggle_fold()<cr>",
							{ desc = "Toggle fold" },
						},
						{
							"n",
							"zR",
							"<cmd>lua require('diffview.actions').open_all_folds()<cr>",
							{ desc = "Open all folds" },
						},
						{
							"n",
							"zM",
							"<cmd>lua require('diffview.actions').close_all_folds()<cr>",
							{ desc = "Close all folds" },
						},
						{
							"n",
							"<tab>",
							"<cmd>lua require('diffview.actions').select_next_entry()<cr>",
							{ desc = "Next entry" },
						},
						{
							"n",
							"<s-tab>",
							"<cmd>lua require('diffview.actions').select_prev_entry()<cr>",
							{ desc = "Prev entry" },
						},
						{
							"n",
							"gf",
							"<cmd>lua require('diffview.actions').goto_file_edit()<cr>",
							{ desc = "Go to file" },
						},
						{
							"n",
							"<C-w><C-f>",
							"<cmd>lua require('diffview.actions').goto_file_split()<cr>",
							{ desc = "Go to file (split)" },
						},
						{
							"n",
							"<C-w>gf",
							"<cmd>lua require('diffview.actions').goto_file_tab()<cr>",
							{ desc = "Go to file (tab)" },
						},
						{
							"n",
							"i",
							"<cmd>lua require('diffview.actions').listing_style()<cr>",
							{ desc = "Toggle listing style" },
						},
						{
							"n",
							"f",
							"<cmd>lua require('diffview.actions').toggle_flatten_dirs()<cr>",
							{ desc = "Toggle flatten dirs" },
						},
						{
							"n",
							"R",
							"<cmd>lua require('diffview.actions').refresh_files()<cr>",
							{ desc = "Refresh files" },
						},
						{
							"n",
							"[c",
							"<cmd>lua require('diffview.actions').prev_conflict()<cr>",
							{ desc = "Prev conflict" },
						},
						{
							"n",
							"]c",
							"<cmd>lua require('diffview.actions').next_conflict()<cr>",
							{ desc = "Next conflict" },
						},
					},
					file_history_panel = {
						{
							"n",
							"g!",
							"<cmd>lua require('diffview.actions').options()<cr>",
							{ desc = "Options" },
						},
						{
							"n",
							"<C-A-d>",
							"<cmd>lua require('diffview.actions').open_in_diffview()<cr>",
							{ desc = "Open in diffview" },
						},
						{
							"n",
							"y",
							"<cmd>lua require('diffview.actions').copy_hash()<cr>",
							{ desc = "Copy commit hash" },
						},
						{
							"n",
							"L",
							"<cmd>lua require('diffview.actions').open_commit_log()<cr>",
							{ desc = "Open commit log" },
						},
						{
							"n",
							"zR",
							"<cmd>lua require('diffview.actions').open_all_folds()<cr>",
							{ desc = "Open all folds" },
						},
						{
							"n",
							"zM",
							"<cmd>lua require('diffview.actions').close_all_folds()<cr>",
							{ desc = "Close all folds" },
						},
						{
							"n",
							"j",
							"<cmd>lua require('diffview.actions').next_entry()<cr>",
							{ desc = "Next entry" },
						},
						{
							"n",
							"k",
							"<cmd>lua require('diffview.actions').prev_entry()<cr>",
							{ desc = "Prev entry" },
						},
						{
							"n",
							"<cr>",
							"<cmd>lua require('diffview.actions').select_entry()<cr>",
							{ desc = "Select entry" },
						},
						{
							"n",
							"o",
							"<cmd>lua require('diffview.actions').select_entry()<cr>",
							{ desc = "Select entry" },
						},
						{
							"n",
							"<2-LeftMouse>",
							"<cmd>lua require('diffview.actions').select_entry()<cr>",
							{ desc = "Select entry" },
						},
						{
							"n",
							"<tab>",
							"<cmd>lua require('diffview.actions').select_next_entry()<cr>",
							{ desc = "Next entry" },
						},
						{
							"n",
							"<s-tab>",
							"<cmd>lua require('diffview.actions').select_prev_entry()<cr>",
							{ desc = "Prev entry" },
						},
						{
							"n",
							"gf",
							"<cmd>lua require('diffview.actions').goto_file_edit()<cr>",
							{ desc = "Go to file" },
						},
						{
							"n",
							"<C-w><C-f>",
							"<cmd>lua require('diffview.actions').goto_file_split()<cr>",
							{ desc = "Go to file (split)" },
						},
						{
							"n",
							"<C-w>gf",
							"<cmd>lua require('diffview.actions').goto_file_tab()<cr>",
							{ desc = "Go to file (tab)" },
						},
						{
							"n",
							"<leader>e",
							"<cmd>lua require('diffview.actions').focus_files()<cr>",
							{ desc = "Focus files" },
						},
						{
							"n",
							"<leader>b",
							"<cmd>lua require('diffview.actions').toggle_files()<cr>",
							{ desc = "Toggle files" },
						},
					},
					option_panel = {
						{
							"n",
							"<tab>",
							"<cmd>lua require('diffview.actions').select_entry()<cr>",
							{ desc = "Select entry" },
						},
						{
							"n",
							"q",
							"<cmd>lua require('diffview.actions').close()<cr>",
							{ desc = "Close" },
						},
					},
				},
			})
		end,
	},
}
