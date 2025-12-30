local M = {}

local state_file = vim.fn.stdpath("data") .. "/theme.txt"
local default_theme = "vscode"

function M.load()
	if vim.fn.filereadable(state_file) == 1 then
		local theme = vim.fn.readfile(state_file)[1]
		if theme and theme ~= "" then
			return theme
		end
	end
	return default_theme
end

function M.save(theme)
	vim.fn.writefile({ theme }, state_file)
end

return M

