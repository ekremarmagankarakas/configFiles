vim.cmd("set number")
vim.cmd("set relativenumber")
vim.cmd("set tabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set softtabstop=2")
vim.cmd("set expandtab")
vim.cmd("set mouse=a")
vim.cmd("set wrap")
vim.cmd("set linebreak")
vim.opt.splitright = true
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.g.python_recommended_style = 0

vim.keymap.set("v", "<leader>y", '"+y', {})
vim.keymap.set("v", "<leader>x", '"+d', {})
vim.keymap.set("n", "<leader>/", ":nohlsearch<CR>", {})
vim.keymap.set("n", "<leader>v", ":vsplit<CR>", {})

vim.keymap.set("n", "<leader>ss", function()
	vim.opt.spell = not vim.opt.spell:get()
end, { desc = "Toggle spell checking" })

local toggle_jk = false

vim.keymap.set("n", "<leader>jk", function()
	if toggle_jk then
		vim.keymap.set("n", "j", "j", { remap = false, silent = true })
		vim.keymap.set("n", "k", "k", { remap = false, silent = true })
		toggle_jk = false
		print("Switched to normal j/k")
	else
		vim.keymap.set("n", "j", "gj", { remap = false, silent = true })
		vim.keymap.set("n", "k", "gk", { remap = false, silent = true })
		toggle_jk = true
		print("Switched to gj/gk")
	end
end, { silent = true })
