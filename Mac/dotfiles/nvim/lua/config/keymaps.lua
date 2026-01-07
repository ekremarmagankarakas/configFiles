-- Toggle Spell Check
vim.keymap.set("n", "<leader>sp", ":setlocal spell!<CR>", { desc = "Toggle spell check" })

-- Go Back Go Forward
vim.keymap.set("n", "<leader>o", "<C-o>", { desc = "Jump back" })
vim.keymap.set("n", "<leader>i", "<C-i>", { desc = "Jump forward" })

-- Yank
vim.keymap.set("v", "<leader>y", '"+y', { desc = "Yank to system clipboard" })
vim.keymap.set("v", "<leader>x", '"+d', { desc = "Cut to system clipboard" })

-- Clear search
vim.keymap.set("n", "<leader>/", ":nohlsearch<CR>", { desc = "Clear search highlight" })

-- Split
vim.keymap.set("n", "<leader>v", ":vsplit<CR>", { desc = "Vertical split" })
vim.keymap.set("n", "<leader>hs", ":split<CR>", { desc = "Horizontal split" })

-- QuickFix Keymaps
vim.keymap.set("n", "<M-j>", "<cmd>cnext<CR>", { desc = "Next quickfix item" })
vim.keymap.set("n", "<M-k>", "<cmd>cprev<CR>", { desc = "Previous quickfix item" })

-- Open Terminal
vim.keymap.set("n", "<leader>t", function()
	vim.cmd("belowright 15split | term")
end, { desc = "Open terminal" })

-- Copilot Toggle
vim.keymap.set("n", "<leader>gct", ":Copilot toggle<CR>", { desc = "Toggle GitHub Copilot" })
vim.keymap.set("n", "<leader>gcd", ":Copilot disable<CR>", { desc = "Disable GitHub Copilot" })
vim.keymap.set("n", "<leader>gce", ":Copilot enable<CR>", { desc = "Enable GitHub Copilot" })

-- Markview Toggle
vim.keymap.set("n", "<leader>sm", ":Markview toggle<CR>", { desc = "Toggle Markview" })

-- Git integration via Telescope
vim.keymap.set("n", "<leader>gtc", "<cmd>Telescope git_commits<cr>", { desc = "Git Commits" })
vim.keymap.set("n", "<leader>gts", "<cmd>Telescope git_status<cr>", { desc = "Git Status" })
vim.keymap.set("n", "<leader>gtB", "<cmd>Telescope git_branches<cr>", { desc = "Git Branches" })

-- DiffViewOpen
vim.keymap.set("n", "<leader>gdv", ":DiffviewOpen ", { desc = "Diff View Open" })

-- Toggle jk
local toggle_jk = false
vim.keymap.set("n", "<leader>sj", function()
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

-- Theme selector
vim.keymap.set("n", "<leader>st", function()
	require("config.theme_picker").pick()
end, { desc = "Pick theme" })

-- Replace strings
vim.keymap.set("n", "<leader>sr", ":%s//gc<Left><Left><Left>", { desc = "Search & replace (global)" })
vim.keymap.set("n", "<leader>sq", ":cdo %s//gc | update<Left><Left><Left><Left><Left><Left><Left><Left>", {
	desc = "Search & replace in quickfix list",
})
