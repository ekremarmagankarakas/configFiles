return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	build = ":Copilot auth",
	event = "InsertEnter",
	opts = {
		suggestion = {
			enabled = true,
			auto_trigger = true,
			debounce = 75,
			keymap = {
				accept = "<Tab>",
				accept_word = "<C-w>",
				accept_line = "<C-l>",
				next = "<C-n>",
				prev = "<C-p>",
				dismiss = "<C-]>",
			},
			layout = {
				align = "top",
				wrap = true,
			},
		},
		panel = {
			enabled = false,
		},
	},
	config = function()
		-- Setup Copilot normally
		require("copilot").setup({
			suggestion = {
				enabled = true,
				auto_trigger = true,
				debounce = 75,
				keymap = {
					accept = "<Tab>",
					accept_word = "<C-w>",
					accept_line = "<C-l>",
					next = "<C-n>",
					prev = "<C-p>",
					dismiss = "<C-]>",
				},
				layout = {
					align = "top",
					wrap = true,
				},
			},
			panel = {
				enabled = false,
			},
		})

		-- 🔥 Copilot toggle keymap
		local copilot_enabled = true
		vim.keymap.set("n", "<leader>tg", function()
			copilot_enabled = not copilot_enabled

			if copilot_enabled then
				vim.cmd("Copilot enable")
				vim.notify("Copilot: ENABLED", vim.log.levels.INFO)
			else
				vim.cmd("Copilot disable")
				vim.notify("Copilot: DISABLED", vim.log.levels.WARN)
			end
		end, { noremap = true, silent = true, desc = "Toggle GitHub Copilot" })
	end,
}
