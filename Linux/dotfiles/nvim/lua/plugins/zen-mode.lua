return {
	"folke/zen-mode.nvim",
	opts = {
		window = {
			options = {
				number = false,
				relativenumber = false,
			},
		},
		on_open = function()
			vim.keymap.set("n", "j", "gj", { buffer = true })
			vim.keymap.set("n", "k", "gk", { buffer = true })
		end,
		on_close = function()
			vim.keymap.del("n", "j", { buffer = true })
			vim.keymap.del("n", "k", { buffer = true })
		end,
	},
}
