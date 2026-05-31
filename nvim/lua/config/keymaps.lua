-- Toggle Spell Check
vim.keymap.set("n", "<leader>sp", "<cmd>setlocal spell!<cr>", { silent = true, desc = "Toggle spell check" })

-- Yank
vim.keymap.set("v", "<leader>y", '"+y', { silent = true, desc = "Yank to system clipboard" })
vim.keymap.set("v", "<leader>x", '"+d', { silent = true, desc = "Cut to system clipboard" })

-- Clear search
vim.keymap.set("n", "<leader>/", "<cmd>nohlsearch<cr>", { silent = true, desc = "Clear search highlight" })

-- Open Terminal
vim.keymap.set("n", "<leader>t", function()
	vim.cmd("belowright 15split | term")
end, { silent = true, desc = "Open terminal" })

-- Terminal: exit insert mode with Escape
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { silent = true, desc = "Terminal: exit insert mode" })

-- Toggle jk
local toggle_jk = false
vim.keymap.set("n", "<leader>sj", function()
	if toggle_jk then
		vim.keymap.set("n", "j", "j", { remap = false, silent = true })
		vim.keymap.set("n", "k", "k", { remap = false, silent = true })
		toggle_jk = false
		vim.notify("Switched to normal j/k")
	else
		vim.keymap.set("n", "j", "gj", { remap = false, silent = true })
		vim.keymap.set("n", "k", "gk", { remap = false, silent = true })
		toggle_jk = true
		vim.notify("Switched to gj/gk")
	end
end, { silent = true, desc = "Toggle j/k and gj/gk" })

-- Theme selector
vim.keymap.set("n", "<leader>st", function()
	require("config.theme_picker").pick()
end, { silent = true, desc = "Theme: pick" })

-- Navigate between splits with Ctrl-hjkl
vim.keymap.set("n", "<C-h>", "<C-w>h", { silent = true, desc = "Move to left split" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { silent = true, desc = "Move to below split" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { silent = true, desc = "Move to above split" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { silent = true, desc = "Move to right split" })

-- Keep selection after indent/unindent
vim.keymap.set("v", "<", "<gv", { silent = true, desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { silent = true, desc = "Indent right and reselect" })

-- Center cursor after search navigation
vim.keymap.set("n", "n", "nzzzv", { silent = true, desc = "Next search result (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { silent = true, desc = "Prev search result (centered)" })

-- Replace strings
vim.keymap.set("n", "<leader>sr", ":%s//gc<Left><Left><Left>", { silent = false, desc = "Search & replace (global)" })
vim.keymap.set(
	"n",
	"<leader>sq",
	":cdo %s//gc | update<Left><left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>",
	{ silent = false, desc = "Search & replace (quickfix)" }
)

-- Toggle Virtual Edit (Jump to any column)
vim.keymap.set("n", "<leader>sv", function()
	if vim.o.virtualedit == "all" then
		vim.o.virtualedit = ""
		print("Virtualedit OFF")
	else
		vim.o.virtualedit = "all"
		print("Virtualedit ON")
	end
end, { silent = true, desc = "Toggle virtual edit" })

-- Floating window helper
local function open_float(buf, title)
	local width = math.floor(vim.o.columns * 0.7)
	local height = math.floor(vim.o.lines * 0.7)
	local row = math.floor((vim.o.lines - height) / 2)
	local col = math.floor((vim.o.columns - width) / 2)

	vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = width,
		height = height,
		row = row,
		col = col,
		style = "minimal",
		border = "rounded",
		title = title and (" " .. title .. " ") or nil,
		title_pos = "center",
	})

	vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = buf, silent = true, desc = "Close float" })
end

-- Scratch buffer (throwaway, no save)
vim.keymap.set("n", "<leader>sb", function()
	local buf = vim.api.nvim_create_buf(false, true)
	vim.bo[buf].bufhidden = "wipe"
	vim.bo[buf].swapfile = false
	vim.bo[buf].filetype = "markdown"
	open_float(buf, "Scratch")
end, { silent = true, desc = "Open scratch buffer (float)" })

-- Cheatsheet (persistent user manual)
local cheatsheet_path = vim.fn.stdpath("data") .. "/cheatsheet.md"
vim.keymap.set("n", "<leader>sm", function()
	if vim.fn.filereadable(cheatsheet_path) == 0 then
		vim.fn.writefile({
			"# My Cheatsheet",
			"",
			"Edit freely. `:w` to save. `q` to close.",
		}, cheatsheet_path)
	end
	local buf = vim.fn.bufadd(cheatsheet_path)
	vim.fn.bufload(buf)
	vim.bo[buf].filetype = "markdown"
	open_float(buf, "Cheatsheet")
end, { silent = true, desc = "Open cheatsheet (float)" })
