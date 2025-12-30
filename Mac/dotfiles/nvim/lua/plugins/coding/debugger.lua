-- lua/plugins/coding/dap.lua
return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"mfussenegger/nvim-dap-python",
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"theHamsta/nvim-dap-virtual-text",
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		----------------------------------------------------------------------
		-- Python interpreter resolution (venv / uv / poetry / fallback)
		----------------------------------------------------------------------
		local function get_python_path()
			local cwd = vim.fn.getcwd()

			-- Project-local virtualenvs
			local candidates = {
				cwd .. "/.venv/bin/python",
				cwd .. "/venv/bin/python",
			}

			for _, path in ipairs(candidates) do
				if vim.fn.executable(path) == 1 then
					return path
				end
			end

			-- Poetry-managed virtualenv
			if vim.fn.executable("poetry") == 1 then
				local handle = io.popen("poetry env info -p 2>/dev/null")
				if handle then
					local result = handle:read("*a")
					handle:close()
					if result and result ~= "" then
						local poetry_python = result:gsub("%s+", "") .. "/bin/python"
						if vim.fn.executable(poetry_python) == 1 then
							return poetry_python
						end
					end
				end
			end

			-- Shell / system fallback
			return "python"
		end

		----------------------------------------------------------------------
		-- DAP Python
		----------------------------------------------------------------------
		require("dap-python").setup(get_python_path())

		----------------------------------------------------------------------
		-- UI and virtual text
		----------------------------------------------------------------------
		dapui.setup()
		require("nvim-dap-virtual-text").setup()

		dap.listeners.after.event_initialized["dapui_open"] = function()
			dapui.open()
		end

		dap.listeners.before.event_terminated["dapui_close"] = function()
			dapui.close()
		end

		dap.listeners.before.event_exited["dapui_close"] = function()
			dapui.close()
		end

		----------------------------------------------------------------------
		-- Keymaps (leader-based, no F-keys)
		----------------------------------------------------------------------
		local map = vim.keymap.set

		map("n", "<leader>dc", dap.continue, { desc = "DAP Continue" })
		map("n", "<leader>dn", dap.step_over, { desc = "DAP Step Over" })
		map("n", "<leader>di", dap.step_into, { desc = "DAP Step Into" })
		map("n", "<leader>do", dap.step_out, { desc = "DAP Step Out" })

		map("n", "<leader>db", dap.toggle_breakpoint, { desc = "DAP Toggle Breakpoint" })
		map("n", "<leader>dB", function()
			dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
		end, { desc = "DAP Conditional Breakpoint" })

		map("n", "<leader>dr", dap.repl.open, { desc = "DAP REPL" })
		map("n", "<leader>dq", dap.terminate, { desc = "DAP Terminate" })
	end,
}

