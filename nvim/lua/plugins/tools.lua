return {
	----------------------------------------------------------------------
	-- Neo-Tree
	----------------------------------------------------------------------
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		main = "neo-tree",
		keys = {
			{ "<leader>nn", "<cmd>Neotree filesystem reveal left<cr>", silent = true, desc = "Neo-tree: reveal" },
			{ "<leader>nt", "<cmd>Neotree toggle<cr>", silent = true, desc = "Neo-tree: toggle" },
		},
		opts = {
			filesystem = {
				filtered_items = {
					visible = true,
					hide_dotfiles = false,
					hide_gitignored = true,
				},
			},
			window = {
				mappings = {
					-- "O" for "Open Externally" (PDFs, Browsers, etc.)
					["O"] = function(state)
						local node = state.tree:get_node()
						local path = node:get_id()
						vim.ui.open(path)
					end,
				},
			},
		},
	},

	----------------------------------------------------------------------
	-- Todo Comments
	----------------------------------------------------------------------
	{
		"folke/todo-comments.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{
				"]t",
				function()
					require("todo-comments").jump_next()
				end,
				desc = "Todo: next comment",
			},
			{
				"[t",
				function()
					require("todo-comments").jump_prev()
				end,
				desc = "Todo: prev comment",
			},
			{ "<leader>fT", "<cmd>TodoTelescope<cr>", desc = "Find: todo comments" },
		},
		opts = {},
	},

	----------------------------------------------------------------------
	-- Flash (enhanced motions)
	----------------------------------------------------------------------
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash: jump",
			},
			{
				"S",
				mode = { "n", "x", "o" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash: treesitter",
			},
			{
				"r",
				mode = "o",
				function()
					require("flash").remote()
				end,
				desc = "Flash: remote",
			},
			{
				"R",
				mode = { "o", "x" },
				function()
					require("flash").treesitter_search()
				end,
				desc = "Flash: treesitter search",
			},
		},
		opts = {},
	},

	----------------------------------------------------------------------
	-- Harpoon
	----------------------------------------------------------------------
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{
				"<leader>ha",
				function()
					require("harpoon"):list():add()
				end,
				desc = "Harpoon: add file",
			},
			{
				"<leader>hd",
				function()
					require("harpoon"):list():remove()
				end,
				desc = "Harpoon: remove file",
			},
			{
				"<leader>hh",
				function()
					local harpoon = require("harpoon")
					harpoon.ui:toggle_quick_menu(harpoon:list())
				end,
				desc = "Harpoon: quick menu",
			},
			{
				"<leader>h1",
				function()
					require("harpoon"):list():select(1)
				end,
				desc = "Harpoon: file 1",
			},
			{
				"<leader>h2",
				function()
					require("harpoon"):list():select(2)
				end,
				desc = "Harpoon: file 2",
			},
			{
				"<leader>h3",
				function()
					require("harpoon"):list():select(3)
				end,
				desc = "Harpoon: file 3",
			},
			{
				"<leader>h4",
				function()
					require("harpoon"):list():select(4)
				end,
				desc = "Harpoon: file 4",
			},
			{
				"<leader>hp",
				function()
					require("harpoon"):list():prev()
				end,
				desc = "Harpoon: prev",
			},
			{
				"<leader>hn",
				function()
					require("harpoon"):list():next()
				end,
				desc = "Harpoon: next",
			},
		},
		config = function()
			require("harpoon"):setup()
		end,
	},

	----------------------------------------------------------------------
	-- Autopairs
	----------------------------------------------------------------------
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup()

			-- Integrate with nvim-cmp if present
			local ok_cmp, cmp = pcall(require, "cmp")
			if ok_cmp then
				local ok_ap, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")
				if ok_ap then
					cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
				end
			end
		end,
	},

	----------------------------------------------------------------------
	-- UndoTree
	----------------------------------------------------------------------
	{
		"mbbill/undotree",
		keys = {
			{ "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Undotree: toggle" },
		},
	},

	----------------------------------------------------------------------
	-- Which Key
	----------------------------------------------------------------------
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {},
		keys = {
			{
				"<leader>?l",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Which-key: buffer local keymaps",
			},
			{
				"<leader>?g",
				function()
					require("which-key").show({ global = true })
				end,
				desc = "Which-key: global keymaps",
			},
		},
		config = function(_, opts)
			local wk = require("which-key")
			wk.setup(opts)

			wk.add({
				{ "<leader>d", group = "debug" },
				{ "<leader>f", group = "find" },
				{ "<leader>g", group = "git" },
				{ "<leader>h", group = "harpoon" },
				{ "<leader>j", group = "java" },
				{ "<leader>l", group = "lsp" },
				{ "<leader>n", group = "neo-tree" },
				{ "<leader>p", group = "pairs/surround" },
				{ "<leader>s", group = "settings" },
				{ "<leader>w", group = "windows" },
			})
		end,
	},

	----------------------------------------------------------------------
	-- Nvim Surround (Lua rewrite of vim-surround)
	----------------------------------------------------------------------
	{
		"kylechui/nvim-surround",
		version = "*",
		keys = {
			{ "<leader>ps", desc = "Surround: add" },
			{ "<leader>pS", desc = "Surround: line" },
			{ "<leader>pd", desc = "Surround: delete" },
			{ "<leader>pc", desc = "Surround: change" },
			{ "<leader>pC", desc = "Surround: change (surrounding)" },
			{ "<leader>ps", mode = "x", desc = "Surround: visual add" },
		},
		opts = {
			keymaps = {
				normal = "<leader>ps",
				normal_cur = "<leader>pS",
				normal_line = false,
				normal_cur_line = false,
				visual = "<leader>ps",
				visual_line = false,
				delete = "<leader>pd",
				change = "<leader>pc",
				change_line = "<leader>pC",
			},
		},
	},

	----------------------------------------------------------------------
	-- nvim-bqf - QuickFix replacement
	----------------------------------------------------------------------
	{
		"kevinhwang91/nvim-bqf",
		ft = "qf",
		opts = {
			preview = {
				winblend = 0,
			},
		},
	},

	----------------------------------------------------------------------
	-- Windows - Maximize
	----------------------------------------------------------------------
	{
		"anuvyklack/windows.nvim",
		dependencies = "anuvyklack/middleclass",
		keys = {
			{ "<leader>wm", "<cmd>WindowsMaximize<cr>", silent = true, desc = "Windows: maximize" },
		},
		opts = {},
	},

	----------------------------------------------------------------------
	-- Markview
	----------------------------------------------------------------------
	{
		"OXY2DEV/markview.nvim",
		main = "markview",
		ft = { "markdown" },
		keys = {
			{ "<leader>sm", "<cmd>Markview toggle<cr>", silent = true, desc = "Markview: toggle" },
		},
		opts = {},
	},

	----------------------------------------------------------------------
	-- VimTex
	----------------------------------------------------------------------
	{
		"lervag/vimtex",
		ft = { "tex" },
		init = function()
			vim.g.vimtex_view_method = "general" -- use default
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
