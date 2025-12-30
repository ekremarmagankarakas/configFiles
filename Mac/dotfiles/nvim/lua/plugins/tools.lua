return {
	----------------------------------------------------------------------
	-- Harpoon
	----------------------------------------------------------------------
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local harpoon = require("harpoon")

			harpoon:setup()

			vim.keymap.set("n", "<leader>ha", function()
				harpoon:list():add()
			end, { desc = "Harpoon Add File" })

			vim.keymap.set("n", "<leader>hd", function()
				harpoon:list():remove()
			end, { desc = "Harpoon Remove File" })

			vim.keymap.set("n", "<C-e>", function()
				harpoon.ui:toggle_quick_menu(harpoon:list())
			end, { desc = "Harpoon Quick Menu" })

			vim.keymap.set("n", "<leader>h1", function()
				harpoon:list():select(1)
			end, { desc = "Harpoon File 1" })
			vim.keymap.set("n", "<leader>h2", function()
				harpoon:list():select(2)
			end, { desc = "Harpoon File 2" })
			vim.keymap.set("n", "<leader>h3", function()
				harpoon:list():select(3)
			end, { desc = "Harpoon File 3" })
			vim.keymap.set("n", "<leader>h4", function()
				harpoon:list():select(4)
			end, { desc = "Harpoon File 4" })

			vim.keymap.set("n", "<leader>hp", function()
				harpoon:list():prev()
			end, { desc = "Harpoon Prev" })

			vim.keymap.set("n", "<leader>hn", function()
				harpoon:list():next()
			end, { desc = "Harpoon Next" })
		end,
	},

	----------------------------------------------------------------------
	-- UndoTree
	----------------------------------------------------------------------
	{
		"mbbill/undotree",

		config = function()
			vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Toggle Undotree" })
		end,
	},

	----------------------------------------------------------------------
	-- Which Key
	----------------------------------------------------------------------
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	},

	----------------------------------------------------------------------
	-- Vim CSS Color
	----------------------------------------------------------------------
	{
		"ap/vim-css-color",
	},

	----------------------------------------------------------------------
	-- VimTex
	----------------------------------------------------------------------
	{
		"lervag/vimtex",
		ft = { "tex" },
		init = function()
			vim.g.vimtex_view_method = "zathura" -- use zathura
			vim.g.vimtex_compiler_method = "latexmk" -- default, explicit here
			vim.g.vimtex_quickfix_mode = 0 -- don't auto-open quickfix on warnings
			vim.g.vimtex_compiler_progname = "nvr" -- for inverse search (requires neovim-remote)

			-- Put all generated files (including PDF) into ./out
			vim.g.vimtex_compiler_latexmk = {
				continuous = 1,
				out_dir = "out",
				options = { "-pdf", "-interaction=nonstopmode", "-synctex=1" },
			}
		end,
	},
}
