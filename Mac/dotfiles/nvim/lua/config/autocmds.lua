vim.api.nvim_create_user_command("MarkdownToPdf", function()
	local current_file = vim.fn.expand("%:p")
	local output_file = vim.fn.fnamemodify(current_file, ":r") .. ".pdf"
	vim.fn.system({ "pandoc", current_file, "-o", output_file })
	print("Converted " .. current_file .. " to " .. output_file)
end, { desc = "Convert current Markdown file to PDF" })

