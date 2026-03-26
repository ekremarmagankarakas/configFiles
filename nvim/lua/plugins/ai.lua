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
			{
				"<leader>aca",
				function()
					local suggestion = require("copilot.suggestion")
					local config = require("copilot.config")
					local current = config.get("suggestion").auto_trigger
					require("copilot.suggestion").toggle_auto_trigger()
					vim.notify("Copilot auto-trigger: " .. (current and "OFF" or "ON"))
				end,
				silent = true,
				desc = "Copilot: toggle auto-trigger",
			},
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
	-- Copilot Chat (for selection prompts)
	----------------------------------------------------------------------
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			"zbirenbaum/copilot.lua",
			"nvim-lua/plenary.nvim",
		},

		-- Builds the fast tokenizer helper if you have make + rust.
		build = "make tiktoken",

		opts = {
			-- UI preferences
			window = {
				layout = "vertical",
				width = 0.3,
			},

			-- Remap chat buffer actions
			mappings = {
				accept_diff = {
					normal = "<leader>ca",
					insert = "<leader>ca",
				},
				show_diff = {
					normal = "<leader>cd",
				},
				yank_diff = {
					normal = "<leader>cy",
				},
			},
		},

		config = function(_, opts)
			local chat = require("CopilotChat")
			chat.setup(opts)

			-- Visual selection hotkeys (send selection, get a response in chat)
			-- Uses the built-in #selection resource so you do not need a selection API.
			vim.keymap.set("v", "<leader>cf", function()
				chat.ask("#selection /Fix", { prompt = "Fix selection" })
			end, { desc = "CopilotChat: Fix selection" })

			vim.keymap.set("v", "<leader>cr", function()
				chat.ask("#selection /Optimize", { prompt = "Refactor selection" })
			end, { desc = "CopilotChat: Refactor selection" })

			vim.keymap.set("v", "<leader>ce", function()
				chat.ask("#selection /Explain", { prompt = "Explain selection" })
			end, { desc = "CopilotChat: Explain selection" })

			vim.keymap.set("v", "<leader>ct", function()
				chat.ask("#selection /Tests", { prompt = "Generate tests for selection" })
			end, { desc = "CopilotChat: Tests for selection" })

			-- open/toggle chat quickly
			vim.keymap.set("n", "<leader>cc", "<cmd>CopilotChatToggle<cr>", { desc = "CopilotChat: Toggle" })
		end,
	},
}
