return {
	----------------------------------------------------------------------
	-- Opencode
	----------------------------------------------------------------------
	{
		"nickjvandyke/opencode.nvim",
		enabled = false,
		version = "*",
		dependencies = {
			{
				"folke/snacks.nvim",
				optional = true,
				opts = {
					input = {},
					picker = {
						actions = {
							opencode_send = function(...)
								return require("opencode").snacks_picker_send(...)
							end,
						},
						win = {
							input = {
								keys = {
									["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
								},
							},
						},
					},
					terminal = {},
				},
			},
		},
		config = function()
			vim.g.opencode_opts = {}
			vim.o.autoread = true

			local op = require("opencode")

			vim.keymap.set({ "n", "x" }, "<leader>aoa", function()
				op.ask("@this: ", { submit = true })
			end, { desc = "opencode: ask (@this)" })
			vim.keymap.set({ "n", "x" }, "<leader>aoe", function()
				op.select()
			end, { desc = "opencode: execute action" })
			vim.keymap.set({ "n", "t" }, "<leader>aot", function()
				op.toggle()
			end, { desc = "opencode: toggle" })

			vim.keymap.set({ "n", "x" }, "<leader>aor", function()
				return op.operator("@this ")
			end, { desc = "opencode: add range (@this)", expr = true })
			vim.keymap.set("n", "<leader>aol", function()
				return op.operator("@this ") .. "_"
			end, { desc = "opencode: add line (@this)", expr = true })

			vim.keymap.set("n", "<leader>aok", function()
				op.command("session.half.page.up")
			end, { desc = "opencode: scroll up" })
			vim.keymap.set("n", "<leader>aoj", function()
				op.command("session.half.page.down")
			end, { desc = "opencode: scroll down" })
		end,
	},

	----------------------------------------------------------------------
	-- 99
	----------------------------------------------------------------------
	{
		"ThePrimeagen/99",
		enabled = false,
		config = function()
			local _99 = require("99")

			_99.setup({
				logger = {
					level = _99.ERROR,
					path = "/tmp/99.debug",
					print_on_error = true,
				},
				provider = _99.OpenCodeProvider,
				model = "openai/gpt-5.2",
				completion = {
					source = nil,
					custom_rules = {},
					files = { enabled = false },
				},
				md_files = {},
			})

			vim.keymap.set("v", "<leader>a9v", function()
				_99.visual()
			end, { desc = "99: Visual prompt" })

			vim.keymap.set("n", "<leader>a9s", function()
				_99.stop_all_requests()
			end, { desc = "99: Stop requests" })

			vim.keymap.set("n", "<leader>a9l", function()
				_99.view_logs()
			end, { desc = "99: View logs" })
		end,
	},

	----------------------------------------------------------------------
	-- Neoscroll
	----------------------------------------------------------------------
	{
		"karb94/neoscroll.nvim",
		enabled = false,
		event = "VeryLazy",
		opts = {
			mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "zt", "zz", "zb" },
			hide_cursor = true,
			stop_eof = true,
			respect_scrolloff = false,
			cursor_scrolls_alone = true,
		},
	},

	----------------------------------------------------------------------
	-- nvim-bqf
	----------------------------------------------------------------------
	{
		"kevinhwang91/nvim-bqf",
		enabled = false,
		ft = "qf",
		opts = {
			preview = {
				winblend = 0,
			},
		},
	},

	----------------------------------------------------------------------
	-- windows.nvim
	----------------------------------------------------------------------
	{
		"anuvyklack/windows.nvim",
		enabled = false,
		dependencies = "anuvyklack/middleclass",
		keys = {
			{ "<leader>wm", "<cmd>WindowsMaximize<cr>", silent = true, desc = "Windows: maximize" },
		},
		opts = {},
	},

	----------------------------------------------------------------------
	-- Git Fugitive
	----------------------------------------------------------------------
	{
		"tpope/vim-fugitive",
        enabled = false,
		cmd = { "Git", "G", "Gvdiffsplit", "Gread", "Gwrite", "Gdiffsplit" },
	},

	----------------------------------------------------------------------
	-- UndoTree
	----------------------------------------------------------------------
	{
		"mbbill/undotree",
        enabled = false,
		keys = {
			{ "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Undotree: toggle" },
		},
	},

	----------------------------------------------------------------------
	-- Todo Comments
	----------------------------------------------------------------------
	{
		"folke/todo-comments.nvim",
        enabled = false,
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
	-- Image viewer
	----------------------------------------------------------------------
	{
		"3rd/image.nvim",
        enabled = false,
		event = "VeryLazy",
		opts = {
			backend = "kitty",
			processor = "magick_cli",
			hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp" },
			max_width_window_percentage = 80,
			max_height_window_percentage = 50,
		},
	},

	----------------------------------------------------------------------
	-- Nvim Surround (Lua rewrite of vim-surround)
	----------------------------------------------------------------------
	{
		"kylechui/nvim-surround",
        enabled = false,
		version = "*",
		keys = {
			{ "<leader>ps", desc = "Surround: add" },
			{ "<leader>pS", desc = "Surround: line" },
			{ "<leader>pd", desc = "Surround: delete" },
			{ "<leader>pc", desc = "Surround: change" },
			{ "<leader>pC", desc = "Surround: change (surrounding)" },
			{ "<leader>ps", mode = "x", desc = "Surround: visual add" },
		},
		opts = {
			keymaps = {
				normal = "<leader>ps",
				normal_cur = "<leader>pS",
				normal_line = false,
				normal_cur_line = false,
				visual = "<leader>ps",
				visual_line = false,
				delete = "<leader>pd",
				change = "<leader>pc",
				change_line = "<leader>pC",
			},
		},
	},

	----------------------------------------------------------------------
	-- Jupytext (view/edit ipynb as text)
	----------------------------------------------------------------------
	{
		"goerz/jupytext.nvim",
        enabled = false,
		event = "VeryLazy",
		config = function()
			local jupytext_ok, jupytext = pcall(require, "jupytext")
			if not jupytext_ok then
				return
			end

			local notebook_view_enabled = true
			local has_jupytext_cli = vim.fn.executable("jupytext") == 1

			local function notify_missing_cli()
				vim.notify(
					"jupytext CLI not found. Install with: pip install jupytext",
					vim.log.levels.WARN
				)
			end

			if not has_jupytext_cli then
				-- Do not register jupytext autocmd handlers; they error on opening .ipynb
				-- when the binary is missing. Keep a toggle command/keymap that explains why.
				vim.api.nvim_create_user_command("JupytextViewToggle", function()
					notify_missing_cli()
				end, { desc = "Notebook: toggle Jupytext view" })

				vim.keymap.set("n", "<leader>su", "<cmd>JupytextViewToggle<cr>", {
					silent = true,
					desc = "Notebook: toggle Jupytext view",
				})
				return
			end

			jupytext.setup({
				format = function()
					return notebook_view_enabled and "markdown" or "ipynb"
				end,
				update = true,
			})

			vim.api.nvim_create_user_command("JupytextViewToggle", function()
				notebook_view_enabled = not notebook_view_enabled
				jupytext.opts.format = notebook_view_enabled and "markdown" or "ipynb"

				local path = vim.api.nvim_buf_get_name(0)
				if path:lower():sub(-6) == ".ipynb" then
					vim.b.jupytext_format = notebook_view_enabled and "markdown" or "ipynb"
					vim.cmd("edit!")
				end

				vim.notify("Notebook view: " .. (notebook_view_enabled and "ON (markdown view)" or "OFF (raw ipynb)"))
			end, { desc = "Notebook: toggle Jupytext view" })

			vim.keymap.set("n", "<leader>su", "<cmd>JupytextViewToggle<cr>", {
				silent = true,
				desc = "Notebook: toggle Jupytext view",
			})
		end,
	},

	----------------------------------------------------------------------
	-- Nvim Colorizer
	----------------------------------------------------------------------
	{
		"NvChad/nvim-colorizer.lua",
        enabled = false,
		event = "BufReadPre",
		opts = {
			filetypes = { "*" },
			user_default_options = {
				RGB = true,
				RRGGBB = true,
				names = false, -- disable named colors (e.g. "Blue")
				RRGGBBAA = true,
				rgb_fn = true,
				hsl_fn = true,
				css = true,
				css_fn = true,
				mode = "background", -- "background" | "foreground" | "virtualtext"
				tailwind = false,
				virtualtext = "■",
			},
		},
	},
}
