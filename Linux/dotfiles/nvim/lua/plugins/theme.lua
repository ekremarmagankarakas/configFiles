return {
	"catppuccin/nvim",
	lazy = false,
	name = "catppuccin",
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			flavour = "mocha", -- latte, frappe, macchiato, mocha
		})
		vim.cmd.colorscheme("catppuccin")
	end,
}

-- return {
--   "EdenEast/nightfox.nvim",
--   lazy = false,
--   priority = 1000,
--   config = function()
--     require('nightfox').setup({
--       options = {
--         styles = {
--           comments = "italic",
--         },
--       },
--     })
--     vim.cmd("colorscheme carbonfox")
--   end,
-- }

-- return {
-- 	"Mofiqul/vscode.nvim",
-- 	priority = 1000,
-- 	config = function()
-- 		vim.cmd.colorscheme("vscode")
-- 	end,
-- }

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

-- return {
-- 	"olimorris/onedarkpro.nvim",
-- 	lazy = false,
-- 	priority = 1000,
-- 	config = function()
-- 		require("onedarkpro").setup({
-- 			-- Choose your theme variant
-- 			-- onedark, onelight, onedark_vivid, onedark_dark, vaporwave
--
-- 			colors = {
-- 				-- Override colors if desired
-- 				-- cursorline = "#2d3139" -- custom cursorline color
-- 			},
--
-- 			styles = {
-- 				comments = "italic",
-- 				keywords = "bold,italic",
-- 				functions = "italic",
-- 				conditionals = "italic",
-- 				types = "italic,bold",
-- 			},
--
-- 			options = {
-- 				cursorline = false,
-- 				transparency = false,
-- 				terminal_colors = true,
-- 				highlight_inactive_windows = false,
-- 			},
--
-- 			-- All plugins enabled by default
-- 			plugins = {
-- 				all = true,
-- 			},
--
-- 			-- All filetypes enabled by default
-- 			filetypes = {
-- 				all = true,
-- 			},
-- 		})
--
-- 		vim.cmd("colorscheme onedark")
-- 	end,
-- }
