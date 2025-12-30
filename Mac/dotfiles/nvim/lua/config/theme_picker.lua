local M = {}

local themes = vim.fn.getcompletion("", "color")

function M.pick()
	local pickers = require("telescope.pickers")
	local finders = require("telescope.finders")
	local conf = require("telescope.config").values
	local actions = require("telescope.actions")
	local action_state = require("telescope.actions.state")

	pickers.new({}, {
		prompt_title = "Themes",
		finder = finders.new_table({ results = themes }),
		sorter = conf.generic_sorter({}),
		attach_mappings = function(_, map)
			map("i", "<CR>", function(bufnr)
				local selection = action_state.get_selected_entry()
				actions.close(bufnr)
				vim.cmd.colorscheme(selection.value)
				require("config.theme_state").save(selection.value)
			end)
			return true
		end,
	}):find()
end

return M

