return {
	----------------------------------------------------------------------
	-- Copilot
	----------------------------------------------------------------------
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		keys = {
			{ "<leader>act", "<cmd>Copilot toggle<cr>", silent = true, desc = "Copilot: toggle" },
			{ "<leader>acd", "<cmd>Copilot disable<cr>", silent = true, desc = "Copilot: disable" },
			{ "<leader>ace", "<cmd>Copilot enable<cr>", silent = true, desc = "Copilot: enable" },
		},
		opts = {
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
		},
	},

	----------------------------------------------------------------------
	-- 99
	----------------------------------------------------------------------
	{
		"ThePrimeagen/99",
		config = function()
			local _99 = require("99")

			_99.setup({
				logger = {
					level = _99.ERROR,
					path = "/tmp/99.debug",
					print_on_error = true,
				},

                -- Model to use
                provider = _99.OpenCodeProvider,
                model = "openai/gpt-5.2",

				-- Visual-only usage: no cmp integration, no rules, no file completion
				completion = {
					source = nil,
					custom_rules = {},
					files = { enabled = false },
				},

				-- Don’t auto-inject AGENT.md files
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
}
