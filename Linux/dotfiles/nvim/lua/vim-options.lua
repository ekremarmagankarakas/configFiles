vim.cmd("set number")
vim.cmd("set relativenumber")
vim.cmd("set tabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set softtabstop=4")
vim.cmd("set expandtab")
vim.cmd("set mouse=a")
vim.cmd("set wrap")
vim.cmd("set linebreak")
vim.opt.splitright = true
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.g.python_recommended_style = 0

vim.keymap.set("v", "<leader>y", '"+y', { desc = "Yank to system clipboard" })
vim.keymap.set("v", "<leader>x", '"+d', { desc = "Cut to system clipboard" })
vim.keymap.set("n", "<leader>/", ":nohlsearch<CR>", { desc = "Clear search highlight" })
vim.keymap.set("n", "<leader>v", ":vsplit<CR>", { desc = "Vertical split" })
vim.keymap.set("n", "<leader>hs", ":split<CR>", { desc = "Horizontal split" })

vim.keymap.set("n", "<M-j>", "<cmd>cnext<CR>", { desc = "Next quickfix item" })
vim.keymap.set("n", "<M-k>", "<cmd>cprev<CR>", { desc = "Previous quickfix item" })

vim.keymap.set("n", "<leader>t", "<cmd>split | term<CR>", { desc = "Open terminal" })

vim.keymap.set("n", "<leader>gt", ":Copilot toggle<CR>", { desc = "Toggle GitHub Copilot" })
vim.keymap.set("n", "<leader>gd", ":Copilot disable<CR>", { desc = "Disable GitHub Copilot" })
vim.keymap.set("n", "<leader>ge", ":Copilot enable<CR>", { desc = "Enable GitHub Copilot" })

vim.keymap.set("n", "<leader>mt", ":Markview toggle<CR>", { desc = "Toggle Markview" })

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
end, { silent = true, desc = "Toggle j/k and gj/gk" })
