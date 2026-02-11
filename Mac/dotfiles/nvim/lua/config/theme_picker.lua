local M = {}

function M.pick()
	-- We call this inside the function so it catches variants
	-- registered by plugins after startup.
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
				-- This replaces the default 'Enter' behavior (opening a file)
				actions.select_default:replace(function()
					local selection = action_state.get_selected_entry()
					actions.close(bufnr)

					if selection then
						-- Apply the theme
						vim.cmd.colorscheme(selection.value)
						-- Persist the choice
						require("config.theme_state").save(selection.value)

						-- Refresh Lualine so it detects the new background (light/dark)
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
