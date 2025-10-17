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
			vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live Grep" })
            vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find Buffers" })
			vim.keymap.set("n", "<leader>fo", builtin.oldfiles, { desc = "Find Old Files" })

            vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help Tags" })
            vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "Keymaps" })
            vim.keymap.set("n", "<leader>fc", builtin.commands, { desc = "Commands" })
            vim.keymap.set("n", "<leader>fC", builtin.command_history, { desc = "Command History" })
            vim.keymap.set("n", "<leader>fs", builtin.current_buffer_fuzzy_find, { desc = "Search in Buffer" })
            vim.keymap.set("n", "<leader>fm", builtin.marks, { desc = "Marks" })
            vim.keymap.set("n", "<leader>fj", builtin.jumplist, { desc = "Jumplist" })
            vim.keymap.set("n", "<leader>fr", builtin.registers, { desc = "Registers" })
            vim.keymap.set("n", "<leader>ft", builtin.treesitter, { desc = "Treesitter Symbols" })
            vim.keymap.set("n", "<leader>f/", builtin.search_history, { desc = "Search History" })
            vim.keymap.set("n", "<leader>fq", builtin.quickfix, { desc = "Quickfix List" })
            vim.keymap.set("n", "<leader>fl", builtin.loclist, { desc = "Location List" })
            
            vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "Find Word Under Cursor" })

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
			end, { desc = "Find Files in Selected Dirs" })

			require("telescope").load_extension("ui-select")
		end,
	},
}
