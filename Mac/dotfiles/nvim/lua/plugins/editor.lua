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
		config = function()
			vim.keymap.set("n", "<leader>nn", ":Neotree filesystem reveal left<CR>")
			vim.keymap.set("n", "<leader>nt", ":Neotree toggle<CR>")
			require("neo-tree").setup({
				filesystem = {
					filtered_items = {
						visible = true,
						hide_dotfiles = false,
						hide_gitignored = true,
					},
				},
			})
		end,
	},

    ----------------------------------------------------------------------
	-- Telescope
	----------------------------------------------------------------------
	{
		{ "stevearc/dressing.nvim", opts = {} },
		{ "nvim-telescope/telescope-ui-select.nvim" },

		{
			"nvim-telescope/telescope.nvim",
			branch = "master",
			dependencies = { "nvim-lua/plenary.nvim" },
			config = function()
				local telescope = require("telescope")

				telescope.setup({
					defaults = {
						sorting_strategy = "ascending",
						layout_strategy = "horizontal",
						layout_config = {
							prompt_position = "top",
							width = 0.95,
							height = 0.95,
							horizontal = {
								preview_width = 0.6, -- preview on the right, larger
							},
						},
						preview = { hide_on_startup = false },
						borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
					},
					extensions = {
						-- Make ui-select follow the same layout instead of dropdown
						["ui-select"] = {
							layout_strategy = "horizontal",
							sorting_strategy = "ascending",
							layout_config = {
								prompt_position = "top",
								width = 0.95,
								height = 0.95,
								horizontal = { preview_width = 0.6 },
							},
						},
					},
				})

				telescope.load_extension("ui-select")

				local builtin = require("telescope.builtin")

				-- All these use the same default layout now
				vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
				vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live Grep" })
				vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find Buffers" })
				vim.keymap.set("n", "<leader>fo", builtin.oldfiles, { desc = "Find Old Files" })
				vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "Find Word Under Cursor" })

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

				-- Multi root finder still uses the same layout, no need to pass layout again
				vim.keymap.set("n", "<leader>fa", function()
					builtin.find_files({
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
			end,
		},
	},

	----------------------------------------------------------------------
	-- TreeSitter
	----------------------------------------------------------------------
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		dependencies = {
			"OXY2DEV/markview.nvim",
		},
		config = function()
			require("nvim-treesitter.configs").setup({
				-- A list of parser names, or "all"
				ensure_installed = {
					"vimdoc",
					"javascript",
					"typescript",
					"c",
					"lua",
					"rust",
					"jsdoc",
					"bash",
					"latex",
					"bibtex",
                    "r",
				},

				-- Install parsers synchronously (only applied to `ensure_installed`)
				sync_install = false,

				-- Automatically install missing parsers when entering buffer
				-- Recommendation: set to false if you don"t have `tree-sitter` CLI installed locally
				auto_install = true,

				indent = {
					enable = true,
				},

				highlight = {
					-- `false` will disable the whole extension
					enable = true,
					disable = function(lang, buf)
						if lang == "html" then
							print("disabled")
							return true
						end

						local max_filesize = 100 * 1024 -- 100 KB
						local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
						if ok and stats and stats.size > max_filesize then
							vim.notify(
								"File larger than 100KB treesitter disabled for performance",
								vim.log.levels.WARN,
								{ title = "Treesitter" }
							)
							return true
						end
					end,

					-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
					-- Set this to `true` if you depend on "syntax" being enabled (like for indentation).
					-- Using this option may slow down your editor, and you may see some duplicate highlights.
					-- Instead of true it can also be a list of languages
					additional_vim_regex_highlighting = { "markdown" },
				},
			})

			local treesitter_parser_config = require("nvim-treesitter.parsers").get_parser_configs()
			treesitter_parser_config.templ = {
				install_info = {
					url = "https://github.com/vrischmann/tree-sitter-templ.git",
					files = { "src/parser.c", "src/scanner.c" },
					branch = "master",
				},
			}

			vim.treesitter.language.register("templ", "templ")
		end,
	},
}
