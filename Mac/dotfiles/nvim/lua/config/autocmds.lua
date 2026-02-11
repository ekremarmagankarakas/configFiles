----------------------------------------------------------------------
-- Markdown to PDF
----------------------------------------------------------------------
vim.api.nvim_create_user_command("MarkdownToPdf", function()
	local current_file = vim.fn.expand("%:p")
	local output_file = vim.fn.fnamemodify(current_file, ":r") .. ".pdf"
	vim.fn.system({ "pandoc", current_file, "-o", output_file })
	print("Converted " .. current_file .. " to " .. output_file)
end, { desc = "Convert current Markdown file to PDF" })

vim.keymap.set("n", "<leader>sc", ":MarkdownToPdf<CR>", { desc = "Convert Markdown to Pdf" })

----------------------------------------------------------------------
-- Trim Trailing Whitespace
----------------------------------------------------------------------
local trim_ws_group = vim.api.nvim_create_augroup("TrimTrailingWhitespace", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
	group = trim_ws_group,
	desc = "Trim trailing whitespace",
	callback = function(args)
		local bufnr = args.buf
		if vim.bo[bufnr].buftype ~= "" then
			return
		end

		-- Keep intentional trailing spaces (e.g. Markdown hard line breaks)
		local ft = vim.bo[bufnr].filetype
		if ft == "markdown" then
			return
		end

		local view = vim.fn.winsaveview()
		vim.cmd([[silent! %s/\s\+$//e]])
		vim.fn.winrestview(view)
	end,
})
