vim.keymap.set("n", "<leader>sp", ":setlocal spell!<CR>", { desc = "Toggle spell check" })

vim.keymap.set("v", "<leader>y", '"+y', { desc = "Yank to system clipboard" })
vim.keymap.set("v", "<leader>x", '"+d', { desc = "Cut to system clipboard" })
vim.keymap.set("n", "<leader>/", ":nohlsearch<CR>", { desc = "Clear search highlight" })
vim.keymap.set("n", "<leader>v", ":vsplit<CR>", { desc = "Vertical split" })
vim.keymap.set("n", "<leader>hs", ":split<CR>", { desc = "Horizontal split" })

vim.keymap.set("n", "<M-j>", "<cmd>cnext<CR>", { desc = "Next quickfix item" })
vim.keymap.set("n", "<M-k>", "<cmd>cprev<CR>", { desc = "Previous quickfix item" })

vim.keymap.set("n", "<leader>t", function()
  vim.cmd("belowright 15split | term")
end, { desc = "Open terminal" })

vim.keymap.set("n", "<leader>gt", ":Copilot toggle<CR>", { desc = "Toggle GitHub Copilot" })
vim.keymap.set("n", "<leader>gd", ":Copilot disable<CR>", { desc = "Disable GitHub Copilot" })
vim.keymap.set("n", "<leader>ge", ":Copilot enable<CR>", { desc = "Enable GitHub Copilot" })

vim.keymap.set("n", "<leader>mt", ":Markview toggle<CR>", { desc = "Toggle Markview" })

-- Git integration via Telescope
vim.keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<cr>", { desc = "Git Commits" })
vim.keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<cr>", { desc = "Git Status" })
vim.keymap.set("n", "<leader>gB", "<cmd>Telescope git_branches<cr>", { desc = "Git Branches" })

-- DiffViewOpen
vim.keymap.set("n", "<leader>dvo", ":DiffviewOpen ", { desc = "Diff View Open" })

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
