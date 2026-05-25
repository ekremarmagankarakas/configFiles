return {
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
}
