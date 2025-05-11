vim.cmd("set number")
vim.cmd("set relativenumber")
vim.cmd("set tabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set mouse=a")
vim.cmd("set wrap")
vim.cmd("set linebreak")
vim.opt.splitright = true
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.keymap.set("v", "<leader>y", '"+y', {})
vim.keymap.set("n", "<leader>n", ":nohlsearch<CR>", {})
vim.keymap.set("n", "<leader>v", ":vsplit<CR>", {})

vim.keymap.set("n", "<leader>ss", function()
	vim.opt.spell = not vim.opt.spell:get()
end, { desc = "Toggle spell checking" })
