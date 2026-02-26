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
	-- Indent Blankline
	----------------------------------------------------------------------
	{
		"lukas-reineke/indent-blankline.nvim",
		enabled = false,
		main = "ibl",
		opts = {
			scope = {
				enabled = true,
				show_start = true,
				show_end = false,
			},
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
}
