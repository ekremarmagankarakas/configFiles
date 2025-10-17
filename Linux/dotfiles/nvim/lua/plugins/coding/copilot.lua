return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	event = "InsertEnter",
	config = function()
		require("copilot").setup({
			suggestion = {
				auto_trigger = true,
				keymap = {
					accept = "<M-y>",
					next = "<M-]>",
					prev = "<M-[>",
					dismiss = "<C-]>",
				},
			},
			panel = { enabled = false },
		})
	end,
}

-- CMP integration for Copilot
-- return {
-- 	{
-- 		"zbirenbaum/copilot.lua",
-- 		event = "InsertEnter",
-- 		config = function()
-- 			require("copilot").setup({
-- 				suggestion = { enabled = false },
-- 				panel = { enabled = false },
-- 			})
-- 		end,
-- 	},
-- 	{
-- 		"zbirenbaum/copilot-cmp",
-- 		dependencies = { "zbirenbaum/copilot.lua" },
-- 		config = function()
-- 			require("copilot_cmp").setup()
-- 		end,
-- 	},
-- }
