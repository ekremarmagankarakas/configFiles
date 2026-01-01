return {
	"mfussenegger/nvim-dap",
	dependencies = {
		-- UI and Core Helpers
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"theHamsta/nvim-dap-virtual-text",
		"jay-babu/mason-nvim-dap.nvim",
		"mason-org/mason.nvim",

		-- Language Specific Helpers
		"mfussenegger/nvim-dap-python", -- Python
		"leoluz/nvim-dap-go", -- Go
		"mxsdev/nvim-dap-vscode-js", -- JS/TS
		"julianolf/nvim-dap-lldb", -- C/C++/Rust
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		----------------------------------------------------------------------
		-- Global Toggles
		----------------------------------------------------------------------
		_G.DAP_JUST_MY_CODE = false
		_G.DAP_USE_VSCODE_LAUNCH = false

		----------------------------------------------------------------------
		-- Mason Setup
		----------------------------------------------------------------------
		require("mason").setup()
		require("mason-nvim-dap").setup({
			ensure_installed = {
				"debugpy",
				"delve",
				"js-debug-adapter",
				"codelldb",
			},
			automatic_installation = true,
		})

		----------------------------------------------------------------------
		-- Prepare Phase (shared by ALL entry points)
		----------------------------------------------------------------------
		local function dap_prepare()
			if not _G.DAP_USE_VSCODE_LAUNCH then
				return
			end

			if vim.fn.filereadable(".vscode/launch.json") == 1 then
				require("dap.ext.vscode").load_launchjs(nil, {
					lldb = { "c", "cpp", "rust" },
					["pwa-node"] = { "javascript", "typescript", "typescriptreact" },
					python = { "python" },
				})
			end
		end

		----------------------------------------------------------------------
		-- Language Specific Setup
		----------------------------------------------------------------------
		-- Python (Mason path)
		local debugpy_path = vim.fn.stdpath("data")
			.. "/mason/packages/debugpy/venv/"
			.. (vim.uv.os_uname().sysname == "Windows_NT" and "Scripts/python.exe" or "bin/python")

		require("dap-python").setup(debugpy_path, {
			justMyCode = function()
				return _G.DAP_JUST_MY_CODE
			end,
		})

		dap.configurations.python = {
			{
				type = "python",
				request = "launch",
				name = "Launch file",
				program = "${file}",
				console = "integratedTerminal",
				justMyCode = function()
					return _G.DAP_JUST_MY_CODE
				end,
			},
		}

		-- Go
		require("dap-go").setup()

		-- C/C++/Rust (via CodeLLDB)
		require("dap-lldb").setup()

		-- JS/TS (Node)
		require("dap-vscode-js").setup({
			adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal" },
		})
		for _, language in ipairs({ "typescript", "javascript", "typescriptreact" }) do
			dap.configurations[language] = {
				{
					type = "pwa-node",
					request = "launch",
					name = "Launch Current File",
					program = "${file}",
					cwd = "${workspaceFolder}",
				},
			}
		end

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
		-- Keymaps
		----------------------------------------------------------------------
		local map = vim.keymap.set
		local dappy = require("dap-python")

		-- Core run (prepare → run)
		map("n", "<leader>dc", function()
			dap_prepare()
			dap.continue()
		end, { desc = "DAP Prepare and Continue" })

		-- Stepping
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

		-- 4. Python Specific (nvim-dap-python)
		map("n", "<leader>ds", function()
			dap_prepare()
			dappy.test_method()
		end, { desc = "Debug nearest Python test" })
		map("n", "<leader>df", function()
			dap_prepare()
			dappy.test_class()
		end, { desc = "Debug Python test class" })
		map("v", "<leader>de", function()
			dap_prepare()
			dappy.debug_selection()
		end, { desc = "Debug selection" })

		-- Toggles
		map("n", "<leader>dtj", function()
			_G.DAP_JUST_MY_CODE = not _G.DAP_JUST_MY_CODE
			vim.notify("DAP justMyCode = " .. tostring(_G.DAP_JUST_MY_CODE))
		end, { desc = "Toggle justMyCode" })
		map("n", "<leader>dtv", function()
			_G.DAP_USE_VSCODE_LAUNCH = not _G.DAP_USE_VSCODE_LAUNCH
			vim.notify("DAP VSCode launch.json = " .. tostring(_G.DAP_USE_VSCODE_LAUNCH))
		end, { desc = "Toggle VS Code launch.json" })
	end,
}
