-- Toggle Spell Check
vim.keymap.set("n", "<leader>sp", "<cmd>setlocal spell!<cr>", { silent = true, desc = "Toggle spell check" })

-- Go Back Go Forward
vim.keymap.set("n", "<leader>o", "<C-o>", { silent = true, desc = "Jump back" })
vim.keymap.set("n", "<leader>i", "<C-i>", { silent = true, desc = "Jump forward" })

-- Yank
vim.keymap.set("v", "<leader>y", '"+y', { silent = true, desc = "Yank to system clipboard" })
vim.keymap.set("v", "<leader>x", '"+d', { silent = true, desc = "Cut to system clipboard" })

-- Clear search
vim.keymap.set("n", "<leader>/", "<cmd>nohlsearch<cr>", { silent = true, desc = "Clear search highlight" })

-- Split
vim.keymap.set("n", "<leader>v", "<cmd>vsplit<cr>", { silent = true, desc = "Vertical split" })
vim.keymap.set("n", "<leader>hs", "<cmd>split<cr>", { silent = true, desc = "Horizontal split" })

-- QuickFix Keymaps
vim.keymap.set("n", "<M-j>", "<cmd>cnext<cr>", { silent = true, desc = "Quickfix: next" })
vim.keymap.set("n", "<M-k>", "<cmd>cprev<cr>", { silent = true, desc = "Quickfix: prev" })

-- Open Terminal
vim.keymap.set("n", "<leader>t", function()
	vim.cmd("belowright 15split | term")
end, { silent = true, desc = "Open terminal" })

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
end, { silent = true, desc = "Theme: pick" })

-- Replace strings
vim.keymap.set("n", "<leader>sr", ":%s//gc<Left><Left><Left>", { silent = false, desc = "Search & replace (global)" })
vim.keymap.set(
	"n",
	"<leader>sq",
	":cdo %s//gc | update<Left><Left><Left><Left><Left><Left><Left><Left>",
	{ silent = false, desc = "Search & replace (quickfix)" }
)
