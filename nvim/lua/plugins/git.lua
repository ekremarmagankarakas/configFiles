return {
	----------------------------------------------------------------------
	-- Git Signs
	----------------------------------------------------------------------
	{
		"lewis6991/gitsigns.nvim",
		main = "gitsigns",
		event = "BufReadPre",
		keys = {
			-- Preview
			{
				"<leader>gp",
				function()
					require("gitsigns").preview_hunk()
				end,
				silent = true,
				desc = "Git: preview hunk",
			},
			{
				"<leader>gP",
				function()
					require("gitsigns").preview_hunk_inline()
				end,
				silent = true,
				desc = "Git: preview hunk inline",
			},

			-- Hunk navigation
			{
				"]g",
				function()
					require("gitsigns").nav_hunk("next")
				end,
				silent = true,
				desc = "Git: next hunk",
			},
			{
				"[g",
				function()
					require("gitsigns").nav_hunk("prev")
				end,
				silent = true,
				desc = "Git: prev hunk",
			},

			-- Stage / Reset (normal + visual)
			{
				"<leader>gs",
				function()
					require("gitsigns").stage_hunk()
				end,
				silent = true,
				desc = "Git: stage hunk",
			},
			{
				"<leader>gs",
				function()
					require("gitsigns").stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end,
				mode = "v",
				silent = true,
				desc = "Git: stage hunk (visual)",
			},
			{
				"<leader>gr",
				function()
					require("gitsigns").reset_hunk()
				end,
				silent = true,
				desc = "Git: reset hunk",
			},
			{
				"<leader>gr",
				function()
					require("gitsigns").reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end,
				mode = "v",
				silent = true,
				desc = "Git: reset hunk (visual)",
			},
			{
				"<leader>gS",
				function()
					require("gitsigns").stage_buffer()
				end,
				silent = true,
				desc = "Git: stage buffer",
			},
			{
				"<leader>gR",
				function()
					require("gitsigns").reset_buffer()
				end,
				silent = true,
				desc = "Git: reset buffer",
			},
			{
				"<leader>gu",
				function()
					require("gitsigns").undo_stage_hunk()
				end,
				silent = true,
				desc = "Git: undo stage hunk",
			},

			-- Toggles
			{
				"<leader>gb",
				function()
					require("gitsigns").toggle_current_line_blame()
				end,
				silent = true,
				desc = "Git: toggle blame",
			},
			{
				"<leader>gT",
				function()
					require("gitsigns").toggle_signs()
				end,
				silent = true,
				desc = "Git: toggle signs",
			},
		},
		opts = {
			on_attach = function(bufnr)
				local gs = require("gitsigns")
				vim.keymap.set({ "o", "x" }, "ih", function()
					gs.select_hunk()
				end, { buffer = bufnr, desc = "Git: select hunk" })
			end,
		},
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
		opts = {
			hooks = {
				diff_buf_read = function(bufnr)
					vim.opt_local.wrap = false
					vim.opt_local.list = false
					vim.opt_local.relativenumber = false
					vim.opt_local.cursorline = false
				end,
				view_opened = function(view)
					vim.notify("DiffView opened", vim.log.levels.INFO)
				end,
			},
			keymaps = {
				view = {
					{ "n", "<leader>dco", "<cmd>lua require('diffview.actions').conflict_choose('ours')<cr>", { desc = "Choose ours" } },
					{ "n", "<leader>dct", "<cmd>lua require('diffview.actions').conflict_choose('theirs')<cr>", { desc = "Choose theirs" } },
					{ "n", "<leader>dcb", "<cmd>lua require('diffview.actions').conflict_choose('base')<cr>", { desc = "Choose base" } },
					{ "n", "<leader>dca", "<cmd>lua require('diffview.actions').conflict_choose('all')<cr>", { desc = "Choose all" } },
					{ "n", "dx", "<cmd>lua require('diffview.actions').conflict_choose('none')<cr>", { desc = "Delete conflict region" } },
				},
			},
		},
	},
}
