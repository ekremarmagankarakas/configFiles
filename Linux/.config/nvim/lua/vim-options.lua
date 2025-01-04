vim.cmd("set number")
vim.cmd("set relativenumber")
vim.cmd("set tabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set mouse=a")
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.keymap.set("v", "<leader>y", '"+y', {})
vim.keymap.set("n", "<leader>n", ":nohlsearch<CR>", {})
