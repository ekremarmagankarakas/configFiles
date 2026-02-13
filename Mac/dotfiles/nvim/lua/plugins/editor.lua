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
			{ "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash: jump" },
			{ "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash: treesitter" },
			{ "r", mode = "o", function() require("flash").remote() end, desc = "Flash: remote" },
			{ "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Flash: treesitter search" },
		},
		opts = {},
	},

	----------------------------------------------------------------------
	-- Telescope
	----------------------------------------------------------------------
	{
		{ "nvim-telescope/telescope-ui-select.nvim" },
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },

		{
			"nvim-telescope/telescope.nvim",
			branch = "master",
			dependencies = { "nvim-lua/plenary.nvim" },
			keys = {
				{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find: files" },
				{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Find: live grep" },
				{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find: buffers" },
				{ "<leader>fo", "<cmd>Telescope oldfiles<cr>", desc = "Find: oldfiles" },
				{ "<leader>fw", "<cmd>Telescope grep_string<cr>", desc = "Find: word under cursor" },
				{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Find: help tags" },
				{ "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Find: keymaps" },
				{ "<leader>fc", "<cmd>Telescope commands<cr>", desc = "Find: commands" },
				{ "<leader>fC", "<cmd>Telescope command_history<cr>", desc = "Find: command history" },
				{ "<leader>fs", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Find: in buffer" },
				{ "<leader>fm", "<cmd>Telescope marks<cr>", desc = "Find: marks" },
				{ "<leader>fj", "<cmd>Telescope jumplist<cr>", desc = "Find: jumplist" },
				{ "<leader>fr", "<cmd>Telescope registers<cr>", desc = "Find: registers" },
				{ "<leader>ft", "<cmd>Telescope treesitter<cr>", desc = "Find: treesitter" },
				{ "<leader>f/", "<cmd>Telescope search_history<cr>", desc = "Find: search history" },
				{ "<leader>fq", "<cmd>Telescope quickfix<cr>", desc = "Find: quickfix" },
				{ "<leader>fl", "<cmd>Telescope loclist<cr>", desc = "Find: loclist" },
				{ "<leader>gtc", "<cmd>Telescope git_commits<cr>", desc = "Git: commits (Telescope)" },
				{ "<leader>gts", "<cmd>Telescope git_status<cr>", desc = "Git: status (Telescope)" },
				{ "<leader>gtB", "<cmd>Telescope git_branches<cr>", desc = "Git: branches (Telescope)" },
				{
					"<leader>fa",
					function()
						local dirs = {
							"~/Workspace",
							"~/Northeastern",
							"~/Work",
							"~/.config/nvim",
							"~/.config/kitty",
							"~/.config/picom",
							"~/.config/rofi",
							"~/.config/starship",
							"~/.config/i3",
							"~/.config/i3ctl",
							"~/.config/securegit",
						}

						-- Filter to only directories that exist
						local search_dirs = {}
						for _, dir in ipairs(dirs) do
							local expanded = vim.fn.expand(dir)
							if vim.fn.isdirectory(expanded) == 1 then
								table.insert(search_dirs, expanded)
							end
						end

						if #search_dirs == 0 then
							vim.notify("No search directories found", vim.log.levels.WARN)
							return
						end

						require("telescope.builtin").find_files({
							prompt_title = "Search in Selected Dirs",
							search_dirs = search_dirs,
							hidden = true,
							no_ignore = true,
							find_command = {
								"fd",
								"--type",
								"f",
								"--hidden",
								"--no-ignore",
								"--exclude",
								"node_modules",
								"--exclude",
								"venv",
								"--exclude",
								".venv",
								"--exclude",
								".git",
								"--exclude",
								"__pycache__",
							},
						})
					end,
					desc = "Find: selected dirs",
				},
			},
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

				telescope.load_extension("fzf")
				telescope.load_extension("ui-select")
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
			"nvim-treesitter/nvim-treesitter-textobjects",
			"windwp/nvim-ts-autotag",
		},
		config = function()
			require("nvim-treesitter.configs").setup({
				-- A list of parser names, or "all"
				ensure_installed = {
					"vimdoc",
					"javascript",
					"typescript",
					"c",
					"cpp",
					"lua",
					"rust",
					"go",
					"gomod",
					"gosum",
					"java",
					"jsdoc",
					"bash",
					"latex",
					"bibtex",
					"r",
					"markdown",
					"markdown_inline",
					"zig",
					"python",
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
							return true
						end

						local max_filesize = 100 * 1024 -- 100 KB
						local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
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

			-- Auto-close and auto-rename HTML/JSX tags
			require("nvim-ts-autotag").setup()

			-- Set up textobjects keymaps manually (required for newer nvim-treesitter)
			local ts_select = require("nvim-treesitter-textobjects.select")
			local ts_move = require("nvim-treesitter-textobjects.move")
			local ts_swap = require("nvim-treesitter-textobjects.swap")

			-- Select
			local select_maps = {
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
				["aa"] = "@parameter.outer",
				["ia"] = "@parameter.inner",
				["ai"] = "@conditional.outer",
				["ii"] = "@conditional.inner",
				["al"] = "@loop.outer",
				["il"] = "@loop.inner",
			}
			for key, query in pairs(select_maps) do
				vim.keymap.set({ "x", "o" }, key, function()
					ts_select.select_textobject(query, "textobjects")
				end, { desc = "TS: " .. query })
			end

			-- Move
			local move_maps = {
				["]m"] = { fn = ts_move.goto_next_start, query = "@function.outer", desc = "Next function start" },
				["]M"] = { fn = ts_move.goto_next_end, query = "@function.outer", desc = "Next function end" },
				["]]"] = { fn = ts_move.goto_next_start, query = "@class.outer", desc = "Next class start" },
				["]["] = { fn = ts_move.goto_next_end, query = "@class.outer", desc = "Next class end" },
				["]a"] = { fn = ts_move.goto_next_start, query = "@parameter.inner", desc = "Next argument" },
				["[m"] = { fn = ts_move.goto_previous_start, query = "@function.outer", desc = "Prev function start" },
				["[M"] = { fn = ts_move.goto_previous_end, query = "@function.outer", desc = "Prev function end" },
				["[["] = { fn = ts_move.goto_previous_start, query = "@class.outer", desc = "Prev class start" },
				["[]"] = { fn = ts_move.goto_previous_end, query = "@class.outer", desc = "Prev class end" },
				["[a"] = { fn = ts_move.goto_previous_start, query = "@parameter.inner", desc = "Prev argument" },
			}
			for key, map in pairs(move_maps) do
				vim.keymap.set({ "n", "x", "o" }, key, function()
					map.fn(map.query, "textobjects")
				end, { desc = map.desc })
			end

			-- Swap
			vim.keymap.set("n", "<leader>a", function()
				ts_swap.swap_next("@parameter.inner", "textobjects")
			end, { desc = "Swap with next argument" })
			vim.keymap.set("n", "<leader>A", function()
				ts_swap.swap_previous("@parameter.inner", "textobjects")
			end, { desc = "Swap with prev argument" })

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
