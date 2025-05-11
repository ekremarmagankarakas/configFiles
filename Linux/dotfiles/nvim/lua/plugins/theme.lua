-- return {
-- 	"catppuccin/nvim",
-- 	lazy = false,
-- 	name = "catppuccin",
-- 	priority = 1000,
-- 	config = function()
-- 		vim.cmd.colorscheme("catppuccin")
-- 	end,
-- }

return {
	"Mofiqul/vscode.nvim",
	priority = 1000,
	config = function()
		vim.cmd.colorscheme("vscode")
	end,
}

-- return {
-- 	"rebelot/kanagawa.nvim",
-- 	priority = 1000,
-- 	config = function()
-- 		vim.cmd.colorscheme("kanagawa-dragon")
-- 	end,
-- }

-- return {
-- 	"projekt0n/github-nvim-theme",
-- 	name = "github-theme",
-- 	lazy = false,
-- 	priority = 1000,
-- 	config = function()
-- 		require("github-theme").setup({})
-- 		vim.cmd("colorscheme github_dark")
-- 	end,
-- }
