return {
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			{ "zbirenbaum/copilot.lua" },
			{ "nvim-lua/plenary.nvim", branch = "master" },
		},
		build = "make tiktoken",
		event = "VeryLazy",
		keys = {
			-- General
			{
				"<leader>cc",
				function()
					require("CopilotChat").toggle()
				end,
				desc = "Toggle Copilot Chat",
			},
			{ "<leader>cm", "<cmd>CopilotChatModels<CR>", desc = "Select Copilot Model" },
			{ "<leader>ca", "<cmd>CopilotChatAgents<CR>", desc = "Select Copilot Agent" },
			{ "<leader>cp", "<cmd>CopilotChatPrompts<CR>", desc = "Select Copilot Prompt" },

			-- Actions
			{ "<leader>ce", "<cmd>CopilotChatExplain<CR>", mode = "n", desc = "Explain Code" },
			{ "<leader>cf", "<cmd>CopilotChatFix<CR>", mode = "v", desc = "Fix Code (Visual)" },
			{ "<leader>cF", "<cmd>CopilotChatFixAll<CR>", desc = "Fix Entire File" },
			{ "<leader>co", "<cmd>CopilotChatOptimize<CR>", mode = "v", desc = "Optimize Code (Visual)" },
			{ "<leader>cd", "<cmd>CopilotChatDocs<CR>", mode = "v", desc = "Generate Docs (Visual)" },
			{ "<leader>ct", "<cmd>CopilotChatTests<CR>", mode = "v", desc = "Generate Tests (Visual)" },
		},
		opts = {
			model = "gpt-4o",
			window = {
				layout = "vertical",
				width = 0.3,
			},
		},
	},
}
