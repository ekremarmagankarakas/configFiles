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
