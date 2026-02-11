-- Global diagnostic UI config
vim.diagnostic.config({
	virtual_text = false,
	underline = true,
	severity_sort = true,
	float = {
		border = "rounded",
		source = true,
		wrap = true,
		max_width = 80,
	},
})

-- Diagnostic state
local vt_on = false
local ul_on = true

-- Toggle virtual text
vim.keymap.set("n", "<leader>lee", function()
	vt_on = not vt_on
	vim.diagnostic.config({ virtual_text = vt_on })
	vim.notify("Virtual text: " .. (vt_on and "ENABLED" or "DISABLED"), vim.log.levels.INFO)
end, { desc = "Diagnostics: toggle virtual text" })

-- Toggle underline
vim.keymap.set("n", "<leader>leu", function()
	ul_on = not ul_on
	vim.diagnostic.config({ underline = ul_on })
	vim.notify("Underline: " .. (ul_on and "ENABLED" or "DISABLED"), vim.log.levels.INFO)
end, { desc = "Diagnostics: toggle underline" })

-- Navigation: next / prev diagnostic
vim.keymap.set("n", "]d", function()
	vim.diagnostic.jump({ count = 1, float = true })
end, { silent = true, desc = "Diagnostics: next" })

vim.keymap.set("n", "[d", function()
	vim.diagnostic.jump({ count = -1, float = true })
end, { silent = true, desc = "Diagnostics: prev" })

-- Navigation: next / prev ERROR only
vim.keymap.set("n", "]e", function()
	vim.diagnostic.jump({ count = 1, float = true, severity = vim.diagnostic.severity.ERROR })
end, { silent = true, desc = "Diagnostics: next error" })

vim.keymap.set("n", "[e", function()
	vim.diagnostic.jump({ count = -1, float = true, severity = vim.diagnostic.severity.ERROR })
end, { silent = true, desc = "Diagnostics: prev error" })

-- Navigation: next / prev WARNING only
vim.keymap.set("n", "]w", function()
	vim.diagnostic.jump({ count = 1, float = true, severity = vim.diagnostic.severity.WARN })
end, { silent = true, desc = "Diagnostics: next warning" })

vim.keymap.set("n", "[w", function()
	vim.diagnostic.jump({ count = -1, float = true, severity = vim.diagnostic.severity.WARN })
end, { silent = true, desc = "Diagnostics: prev warning" })

-- Send diagnostics to quickfix / loclist
vim.keymap.set("n", "<leader>leq", function()
	vim.diagnostic.setqflist()
end, { silent = true, desc = "Diagnostics: send to quickfix" })

vim.keymap.set("n", "<leader>lel", function()
	vim.diagnostic.setloclist()
end, { silent = true, desc = "Diagnostics: send to loclist" })

