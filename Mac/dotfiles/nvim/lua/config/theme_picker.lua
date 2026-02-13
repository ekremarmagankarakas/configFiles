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

function M.pick()
	-- Force-load all lazy theme plugins so their colorschemes are registered.
	-- Colorscheme plugins are just highlight tables — negligible memory cost.
	local lazy_plugins = require("lazy").plugins()
	for _, plugin in ipairs(lazy_plugins) do
		if plugin.priority == 1000 and plugin.lazy and not plugin._.loaded then
			require("lazy").load({ plugins = { plugin.name } })
		end
	end

	-- Now getcompletion returns all available colorschemes.
	local themes = vim.fn.getcompletion("", "color")

	local pickers = require("telescope.pickers")
	local finders = require("telescope.finders")
	local conf = require("telescope.config").values
	local actions = require("telescope.actions")
	local action_state = require("telescope.actions.state")

	pickers
		.new({}, {
			prompt_title = "Themes",
			finder = finders.new_table({ results = themes }),
			sorter = conf.generic_sorter({}),
			attach_mappings = function(bufnr, map)
				actions.select_default:replace(function()
					local selection = action_state.get_selected_entry()
					actions.close(bufnr)

					if selection then
						vim.cmd.colorscheme(selection.value)
						M.save(selection.value)

						if package.loaded["lualine"] then
							require("lualine").setup({ options = { theme = "auto" } })
						end
					end
				end)
				return true
			end,
		})
		:find()
end

return M
