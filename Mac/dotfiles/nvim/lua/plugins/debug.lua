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
		local dappy = require("dap-python")

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
		dappy.setup(get_python_path())

		----------------------------------------------------------------------
		-- UI and virtual text
		----------------------------------------------------------------------
		dapui.setup()
		require("nvim-dap-virtual-text").setup()

        -- Auto open dap ui
		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end

		----------------------------------------------------------------------
		-- Keymaps
		----------------------------------------------------------------------
		local map = vim.keymap.set

		-- 1. Core Execution (Step & Navigation)
		map("n", "<leader>dc", dap.continue, { desc = "DAP Continue" })
		map("n", "<leader>dn", dap.step_over, { desc = "DAP Step Over" })
		map("n", "<leader>di", dap.step_into, { desc = "DAP Step Into" })
		map("n", "<leader>do", dap.step_out, { desc = "DAP Step Out" })
		map("n", "<leader>dC", dap.run_to_cursor, { desc = "DAP Run to Cursor" })

		-- 2. Breakpoints
		map("n", "<leader>db", dap.toggle_breakpoint, { desc = "DAP Toggle Breakpoint" })
		map("n", "<leader>dB", function()
			dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
		end, { desc = "DAP Conditional Breakpoint" })
		map("n", "<leader>dl", function()
			dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
		end, { desc = "DAP Logpoint" })

		-- 3. Inspection & UI
		map("n", "<leader>dh", function()
			require("dap.ui.widgets").hover()
		end, { desc = "DAP Hover" })
		map("v", "<leader>dh", function()
			require("dap.ui.widgets").hover()
		end, { desc = "DAP Hover Selection" })
		map("n", "<leader>dr", dap.repl.toggle, { desc = "DAP Toggle REPL" })
		map("n", "<leader>dq", dap.terminate, { desc = "DAP Terminate" })
		map("n", "<leader>du", dapui.toggle, { desc = "DAP UI Toggle" })
		map("n", "<leader>dU", dapui.open, { desc = "DAP UI Open" })
		map("n", "<leader>dx", dapui.close, { desc = "DAP UI Close" })

		-- 4. Python Specific (nvim-dap-python)
		map("n", "<leader>ds", function()
			dappy.test_method()
		end, { desc = "Debug nearest Python test" })
		map("n", "<leader>df", function()
			dappy.test_class()
		end, { desc = "Debug current Python test class" })
		map("v", "<leader>de", function()
			dappy.debug_selection()
		end, { desc = "Debug Selection" })
	end,
}
