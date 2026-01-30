-- Global diagnostic UI config
vim.diagnostic.config({
	virtual_text = false,
	underline = true,
	float = {
		border = "rounded",
		source = "always",
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
	vim.notify(
		"Virtual text: " .. (vt_on and "ENABLED" or "DISABLED"),
		vim.log.levels.INFO
	)
end, { desc = "Diagnostics: toggle virtual text" })

-- Toggle underline
vim.keymap.set("n", "<leader>leu", function()
	ul_on = not ul_on
	vim.diagnostic.config({ underline = ul_on })
	vim.notify(
		"Underline: " .. (ul_on and "ENABLED" or "DISABLED"),
		vim.log.levels.INFO
	)
end, { desc = "Diagnostics: toggle underline" })


