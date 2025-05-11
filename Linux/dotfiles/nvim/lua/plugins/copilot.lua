return {
	"github/copilot.vim",
	config = function()
		vim.g.copilot_enabled = true -- start enabled by default

		-- Define toggle function
		vim.api.nvim_create_user_command("CopilotToggle", function()
			if vim.g.copilot_enabled then
				vim.cmd("Copilot disable")
				vim.g.copilot_enabled = false
				vim.notify("GitHub Copilot Disabled", vim.log.levels.INFO)
			else
				vim.cmd("Copilot enable")
				vim.g.copilot_enabled = true
				vim.notify("GitHub Copilot Enabled", vim.log.levels.INFO)
			end
		end, {})

		-- Map <leader>tg to toggle Copilot
		vim.keymap.set("n", "<leader>tg", "<cmd>CopilotToggle<CR>", { desc = "Toggle GitHub Copilot" })
	end,
}
