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
	-- Telescope
	----------------------------------------------------------------------
	{
		{ "stevearc/dressing.nvim", opts = {} },
		{ "nvim-telescope/telescope-ui-select.nvim" },

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
		dependencies = {},
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
