return {
	"Mofiqul/vscode.nvim",
	priority = 1000,
	config = function()
		local theme_state = require("config.theme_state")
		vim.cmd.colorscheme(theme_state.load())
	end,
}
