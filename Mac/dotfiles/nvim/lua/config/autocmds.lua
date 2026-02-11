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
		if ft == "markdown" or ft == "rmd" then
			return
		end

		local view = vim.fn.winsaveview()
		vim.cmd([[silent! %s/\s\+$//e]])
		vim.fn.winrestview(view)
	end,
})

----------------------------------------------------------------------
-- R integration
----------------------------------------------------------------------
-- R convert to pdf and html
local rmd_group = vim.api.nvim_create_augroup("RmdIntegration", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
	group = rmd_group,
	pattern = "rmd",
	callback = function(args)
		local buf = args.buf

		local function render_rmd(format)
			local file = vim.fn.expand("%:p")
			if file == "" then
				vim.notify("No file to render", vim.log.levels.ERROR)
				return
			end

			local cmd
			if format == "html" then
				cmd = string.format("Rscript -e \"rmarkdown::render('%s')\"", file)
			elseif format == "pdf" then
				cmd = string.format("Rscript -e \"rmarkdown::render('%s', output_format='pdf_document')\"", file)
			end

			vim.notify("Rendering Rmd to " .. format .. "...", vim.log.levels.INFO)
			vim.fn.jobstart(cmd, {
				stdout_buffered = true,
				stderr_buffered = true,
				on_stdout = function(_, data)
					if data then
						for _, line in ipairs(data) do
							if line ~= "" then
								vim.notify(line, vim.log.levels.INFO)
							end
						end
					end
				end,
				on_stderr = function(_, data)
					if data then
						for _, line in ipairs(data) do
							if line ~= "" then
								vim.notify(line, vim.log.levels.ERROR)
							end
						end
					end
				end,
				on_exit = function(_, code)
					if code == 0 then
						vim.notify("Rmd render finished", vim.log.levels.INFO)
					else
						vim.notify("Rmd render failed", vim.log.levels.ERROR)
					end
				end,
			})
		end

		vim.keymap.set("n", "<leader>rh", function()
			render_rmd("html")
		end, { buffer = buf, desc = "Render Rmd to HTML" })

		vim.keymap.set("n", "<leader>rp", function()
			render_rmd("pdf")
		end, { buffer = buf, desc = "Render Rmd to PDF" })
	end,
})
